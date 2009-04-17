class BuddiesController < ApplicationController
  # GET /buddies
  # GET /buddies.xml
  
  before_filter :get_logged_in_user
  
  def index
    @buddy_groups = @user.buddy_groups
    @buddies = @user.buddies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buddies }
    end
  end

  # GET /buddies/1
  # GET /buddies/1.xml
  def show
    @buddy = Buddy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @buddy }
    end
  end

  # GET /buddies/new
  # GET /buddies/new.xml
  def new
    @buddy = Buddy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @buddy }
    end
  end

  # GET /buddies/1/edit
  def edit
    @buddy = Buddy.find(params[:id])
  end

  # POST /buddies
  # POST /buddies.xml
  def create
    @buddy = Buddy.new(params[:buddy])
    @buddy.user = User.find_by_login(params[:user])
    
    respond_to do |format|
      if @buddy.save
        flash[:notice] = 'Buddy was successfully created.'
        format.html { redirect_to dashboard_path }
        format.xml  { render :xml => @buddy, :status => :created, :location => @buddy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @buddy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buddies/1
  # PUT /buddies/1.xml
  def update
    @buddy = Buddy.find(params[:id])

    respond_to do |format|
      if @buddy.update_attributes(params[:buddy])
        flash[:notice] = 'Buddy was successfully updated.'
        format.html { redirect_to :back }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @buddy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buddies/1
  # DELETE /buddies/1.xml
  def destroy
    @buddy = Buddy.find(params[:id])
    @buddy.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def get_logged_in_user
    @user = User.find(session[:user_id])
  end
  
  
end
