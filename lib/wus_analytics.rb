class WusAnalytics
  
  def initialize(user)
    @user = user
  end
  
  def interesting_statistics
    data = {}
    data['users_who_speak_same_language'] = users_who_speak_same_language.length
    return data
  end
  
  private
  
  def users_who_speak_same_language
    language = @user.language
    language.users
  end    
    
end