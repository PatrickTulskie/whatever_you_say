class DashboardController < ApplicationController

  layout 'logged_in'
  
  def index
    @user = User.find(session[:user_id])
    @chats = Chat.find_all_by_member(@user)
    @buddy_groups = @user.buddy_groups
  end  
  
end
