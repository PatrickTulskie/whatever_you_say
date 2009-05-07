class WusAnalytics
  
  def initialize(user)
    @user = user
  end
  
  def interesting_statistics
    data = {}
    data['users_who_speak_same_language'] = users_who_speak_same_language.length
    data['users_who_speak_other_languages'] = users_who_speak_other_languages.length
    data['most_common_language'] = most_common_language
    return data
  end
  
  def users_who_speak_same_language
    language = @user.language
    language.users
  end
  
  def users_who_speak_other_languages
    users = User.all - @user.language.users
  end
  
  def most_common_language
    counts = {}
    langs = Language.find(:all, :include => :users)
    langs.each{ |language| counts[language.name] = language.users.length }
    return counts.sort{ |a,b| a.last <=> b.last }.last.first
  end
    
end