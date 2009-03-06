class ChatsController < ApplicationController
  # GET /chats
  # GET /chats.xml
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
    @user = @chat.user
    @receiver = @chat.receiver
    @message = Message.new
    @chat.mark_all_read(session[:user_id])
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
    @chat.mark_all_read(session[:user_id])
    respond_to do |format|
      if @message.save
        update_chat_window
        # format.html { redirect_to(:back) }
        # format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        # format.html { redirect_to(:back) }
        # format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update_chat_window
    chat = Chat.find(params[:chat_id])
    new_messages = chat.get_unread_messages(session[:user_id])
    response = ""
    new_messages.each do |message|
      response << "<tr id=\"message_#{message.id}\"><td><b>#{message.sender.login.titleize}:</b></td><td>#{message.body}</td></tr>"
    end
    render :text => response
  end  
  
end
