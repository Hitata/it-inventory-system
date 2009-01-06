class ModelNamesController < ApplicationController
  def index
    @model_names = ModelName.find(:all)
  end

  def new
    @model_name = ModelName.new
  end

  def update
    @model_name = ModelName.find(params[:id])
    respond_to do |format|
      if @model_name.update_attributes(params[:model_name])
        :flash[:notice] = 'Model name was successfully updated.'
        format.html {redirect_to(:action => :index)}
      else
        format.html {render :action => :edit }
      end
    end
    
  end
  
  def edit
    @model_name = ModelName.find(params[:id])
  end
  
  def create
    @model_name = ModelName.new(params[:model_name])
    respond_to do |format|
      if @model_name.save
        format.html { redirect_to(:action => :index)}
      else
        format.html {render :action => :new}
      end
    end
  end

  def destroy
    @model_name = ModelName.find(params[:id])
    @model_name.destroy

    respond_to do |format|
      format.html {redirect_to(:action => :index)}
    end
  end 
  

end
