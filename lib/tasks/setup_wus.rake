require 'google_translate'

namespace :wus do
  
  desc "Setup the application."
  task :setup => :environment do
    # Create admin role
    admin_role = Role.create(:name => 'admin')

    # Create default admin user
    user = User.create do |u|
      u.login = 'admin'
      u.password = u.password_confirmation = 'wuspassword'
      u.email = APP_CONFIG[:admin_email]
    end

    # Activate user
    user.register!
    user.activate!

    # Add admin role to admin user
    user.roles << admin_role
  end
  
  desc "Create the database"
  task :create do
     db_info=load_db
     create_it = %(echo "create database #{db_info['database']}" | mysql -u #{db_info['username']} --password=#{db_info['password']})        
    `#{create_it}`
  end
  
  desc "Drop the database"
  task :demolish do
    db_info=load_db
    drop_it = %(echo "drop database #{db_info['database']}" | mysql -u #{db_info['username']} --password=#{db_info['password']})    
    `#{drop_it}`
  end
  
  desc "Import the Languages"
  task :setup_languages => :environment do
    puts "Importing from shvet-google_translate"
    g = Google::Translator.new
    g.supported_languages[:from_languages].each do |lang|
      l = Language.find_or_create_by_name_and_short_name(lang.name, lang.code)
      l.save
      puts "Imported #{lang.name}."
    end
    puts "---------------------------------------"
    puts "Importing from regular google translate"
    google_translate_gem_languages.each do |lang|
      l = Language.find_or_create_by_name_and_short_name(lang[:name], lang[:short_name])
      l.save
      puts "Imported #{l.name}"
    end
  end
    
end

def load_db
  YAML.load(File.open(File.dirname(__FILE__)+'/../../config/database.yml', 'r').read)[RAILS_ENV]
end

def google_translate_gem_languages
  require 'rtranslate'
  Translate::Language.constants.reject{|c| c=="AVAILABLE_PAIR"}.map{ |c| {:name => c.titleize, :short_name => Translate::Language.const_get(c.to_sym)} }
end
