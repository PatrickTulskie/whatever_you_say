class DashboardController < ApplicationController

  layout 'logged_in'
  
  def index
    @user = User.find(session[:user_id])
    @chats = @user.chats
    @buddy_groups = @user.buddy_groups
  end  
  
end
