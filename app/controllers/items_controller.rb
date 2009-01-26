class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    @items = Item.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])
    @feature = Feature.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
      format.js
    end
  end
  
  def get_models_for_manufacturer 
    @model_names = ModelName.find_all_by_manufacturer_id(params["manufacturer_id"])
    
    ####@model_names = ModelName.find(:all, :conditions => {:manufacturer_id => params["manufacturer_id"]})

    @html = "<select id='item_model_name_id' name='item[model_name_id]'>"
    @html += "<option value="">Select Model</option>"
    @model_names.each do |model_name|
      @html += "<option value='#{model_name.id}'>#{model_name.name}</option>"
    end
    @html += "</select>"
    
    render(:text => @html)
    
  end
  
  def add_feature
    render :partial => "add_a_feature"
  end
  
  
  
  def remove_from_features

    feature = Feature.find(params[:id])
    @item = feature.item
    @current_feature = feature.destroy
    respond_to do |format|
      format.js if request.xhr?
      format.html { redirect_to :action => 'show', :id => @item}

    end

  end
  

  
  def createfeature
    @item = Item.find(params[:feature][:item_id])
    @feature = Feature.new(params[:feature])
    @feature.save
    
    respond_to do |format|
      format.js
    end
    


  end
  

end
