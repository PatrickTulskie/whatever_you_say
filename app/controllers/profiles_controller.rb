class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.xml
  
  before_filter :find_current_user, :only => [:index, :edit, :update, :show]
  layout 'logged_in'
  
  def index
    unless @user.has_role?(:admin)
      redirect_to profile_path(@user.profile) and return
    end
    @profiles = Profile.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
   @profile = Profile.find(params[:id])
          
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @profile }
    end
  end

  # # GET /profiles/new
  # # GET /profiles/new.xml
  # def new
  #   @profile = Profile.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @profile }
  #     
  #   @profile.save
  #   end
  # end

  # GET /profiles/1/edit
  def edit
    if params[:id] != 0 
      @profile = Profile.find(params[:id])
    else
      # Handles the unlikely event that the currently logged in user doesn't have a profile
      @profile = Profile.new
      @user.profile = @profile
      @profile.save
    end
    if !@user.has_role?(:admin) && @profile != @user.profile
      redirect_to edit_profile_path(@user.profile)
    end
      
  end

  # POST /profiles
  # POST /profiles.xml
  def create
     @profile = Profile.new(params[:profile])
  # @user = @profile.email params[:email]   
     respond_to do |format|
       if @profile.save
         flash[:notice] = 'Profile was successfully created.'
         format.html { redirect_to(@profile) }
         format.xml  { render :xml => @profile, :status => :created, :location => @profile }
       else
         @profile.errors << @profile.user.errors
         format.html { render :action => "new" }
         format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
       end
     end
   end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    # render :text => "<pre>#{params.to_yaml}</pre>" and return
    @profile = Profile.find(params[:id])
    # @profile = Profile.find_or_create_by_user_id(@user.id)
    unless params.empty?
      @profile.update_attributes(params[:profile])
      @profile.user.update_attributes(params[:user])
    end
    respond_to do |format|
      if @profile.errors.empty? && @profile.user.errors.empty?
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to(@profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors + @profile.user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # def check_profile
  #   if @profile = Profile.find_or_create_by_user_id(session[:user_id]) 
  #     redirect_to :action => 'edit', :id => @profile
  #     @profile.save
  #   end
  # end
  

  # # DELETE /profiles/1
  # # DELETE /profiles/1.xml
  # def destroy
  #   @profile = Profile.find(params[:id])
  #   @profile.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(profiles_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  
end
