class BuddyGroupsController < ApplicationController
  # GET /buddy_groups
  # GET /buddy_groups.xml
  def index
    @buddy_groups = BuddyGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buddy_groups }
    end
  end

  # GET /buddy_groups/1
  # GET /buddy_groups/1.xml
  def show
    @buddy_group = BuddyGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @buddy_group }
    end
  end

  # GET /buddy_groups/new
  # GET /buddy_groups/new.xml
  def new
    @buddy_group = BuddyGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @buddy_group }
    end
  end

  # GET /buddy_groups/1/edit
  def edit
    @buddy_group = BuddyGroup.find(params[:id])
  end

  # POST /buddy_groups
  # POST /buddy_groups.xml
  def create
    @buddy_group = BuddyGroup.new(params[:buddy_group])

    respond_to do |format|
      if @buddy_group.save
        flash[:notice] = 'BuddyGroup was successfully created.'
        format.html { redirect_to(@buddy_group) }
        format.xml  { render :xml => @buddy_group, :status => :created, :location => @buddy_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @buddy_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buddy_groups/1
  # PUT /buddy_groups/1.xml
  def update
    @buddy_group = BuddyGroup.find(params[:id])

    respond_to do |format|
      if @buddy_group.update_attributes(params[:buddy_group])
        flash[:notice] = 'BuddyGroup was successfully updated.'
        format.html { redirect_to(@buddy_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @buddy_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buddy_groups/1
  # DELETE /buddy_groups/1.xml
  def destroy
    @buddy_group = BuddyGroup.find(params[:id])
    @buddy_group.destroy

    respond_to do |format|
      format.html { redirect_to(buddy_groups_url) }
      format.xml  { head :ok }
    end
  end
end
