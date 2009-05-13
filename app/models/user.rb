require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  # Validations
  validates_presence_of :login, :if => :not_using_openid?
  validates_length_of :login, :within => 3..40, :if => :not_using_openid?
  validates_uniqueness_of :login, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :login, :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD, :if => :not_using_openid?
  validates_format_of :name, :with => RE_NAME_OK, :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of :name, :maximum => 100
  validates_presence_of :email, :if => :not_using_openid?
  validates_length_of :email, :within => 6..100, :if => :not_using_openid?
  validates_uniqueness_of :email, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD, :if => :not_using_openid?
  validates_uniqueness_of :identity_url, :unless => :not_using_openid?
  validate :normalize_identity_url
  validates_confirmation_of :password
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 8..40, :if => :password_required?
  
  # Relationships
  has_and_belongs_to_many :roles
  has_one :profile, :dependent => :destroy
  has_one :language, :through => :profile
  has_many :buddy_groups
  has_many :chats
  
  # Actions
  after_create :create_profile

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url, :language

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => { :login => login } # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  
  # Check if a user has a role.
  def has_role?(role)
    list ||= self.roles.map(&:name)
    list.include?(role.to_s) || list.include?('admin')
  end
  
  # Not using open id
  def not_using_openid?
    identity_url.blank?
  end
  
  # Overwrite password_required for open id
  def password_required?
    new_record? ? not_using_openid? && (crypted_password.blank? || !password.blank?) : !password.blank?
  end
  
  def buddies
    self.buddy_groups.map{|group| group.buddies }.flatten
  end
  
  def all_chats
    Chat.find_all_by_member(self.id)
  end
  
  def current_chats
    all_chats.reject{ |chat| chat.details_for(self)[:closed] == true }
  end  
    
  def chat_with_user(user)
    answer = nil
    self.all_chats.each do |chat|
      if (chat.user == self && chat.receiver == user) || (chat.receiver == self && chat.user == self)
        answer = chat
      end
    end
    return answer
  end

  protected
    
  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end
  
  def normalize_identity_url
    self.identity_url = OpenIdAuthentication.normalize_url(identity_url) unless not_using_openid?
  rescue URI::InvalidURIError
    errors.add_to_base("Invalid OpenID URL")
  end
  
  def create_profile
    lang = Language.find_by_short_name('en') || Language.first
    if lang
      self.profile = Profile.create({:language_id => lang.id })
    else
      self.profile = Profile.new
      self.profile.save
    end
  end
    
end
