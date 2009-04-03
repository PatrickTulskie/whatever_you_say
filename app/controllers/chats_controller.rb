class ChatsController < ApplicationController
  # GET /chats
  # GET /chats.xml
  layout 'logged_in'
  # before_filter :find_current_user
  
  def index
    if session
      @chats = Chat.find_all_by_member(session[:user_id])
    else
      @chats = Chat.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chats }
    end
  end

  # GET /chats/1
  # GET /chats/1.xml
  def show
    @chat = Chat.find(params[:id])
    @user = User.find(session[:user_id])
    @receiver = @chat.receiver
    @message = Message.new
    @chat.mark_all_read(session[:user_id])
    @messages = (@chat.messages.length > 0) ? translate_messages(@chat.messages, @user.language) : []
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chat }
    end
  end

  # GET /chats/new
  # GET /chats/new.xml
  def new
    @chat = Chat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chat }
    end
  end

  # GET /chats/1/edit
  def edit
    @chat = Chat.find(params[:id])
  end

  # POST /chats
  # POST /chats.xml
  def create
    @chat = Chat.new(params[:chat])

    respond_to do |format|
      if @chat.save
        flash[:notice] = 'Chat was successfully created.'
        format.html { redirect_to(@chat) }
        format.xml  { render :xml => @chat, :status => :created, :location => @chat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chats/1
  # PUT /chats/1.xml
  def update
    @chat = Chat.find(params[:id])

    respond_to do |format|
      if @chat.update_attributes(params[:chat])
        flash[:notice] = 'Chat was successfully updated.'
        format.html { redirect_to(@chat) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.xml
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to(chats_url) }
      format.xml  { head :ok }
    end
  end
  
  def create_message
    @message = Message.new(params[:message])
    @chat = @message.chat
    if @message.save
      # update_chat_window(@chat.id)
      render :partial => 'message', :locals => {:message => @message, :highlight => true}
      @chat.mark_all_read(session[:user_id])
    else
      render :nothing => true
    end
  end
  
  def update_chat_window(chat_id=nil)
    chat = Chat.find(chat_id.nil? ? params[:chat_id] : chat_id)
    user = User.find(session[:user_id])
    messages = chat.get_unread_messages(user.id).reject{|m|m.sender_id==user.id}
    new_messages = translate_messages(messages, user.language)
    
    if new_messages.length > 0
      render :partial => 'message', :collection => new_messages, :locals => {:highlight => true }
    else
      render :nothing => true
    end
  end
  
  private
  
  def translate_messages(messages, language)
    new_messages = []
    messages.each do |message|
      trans_message = message
      if language.id != message.language.id
        trans_message.body = message.translate(language.short_name)
      end
      new_messages << trans_message
    end
    return new_messages
  end
  
  
end
