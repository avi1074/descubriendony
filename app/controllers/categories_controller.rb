class CategoriesController < ApplicationController

  def new
    city = get_city
    @category = Category.new(city: city)
    @categories = Category.where(:category_id => nil, :city => city).order_by("position ASC")
    @activities = Activity.where(:city => city)
    @related_activities = if @category.nil? then [] else @category.activities.map {|j| j._id} end

  end

  def create
    @sub_category = Category.new
    @sub_category.name_translations = {en: params[:english_name], es: params[:spanish_name], pt: params[:portuguese_name]}
    @sub_category.position = params[:category][:position]
    @sub_category.city = params[:category][:city]
    Rails.logger.debug(params)
    if params[:type] == "children"
      @sub_category.category_image = params[:category][:category_image]
      @category = Category.find(params[:category][:category_id])
    end

    respond_to do |format|
      if params[:type] == "children"
        if @category.categories.push(@sub_category)
          format.html { redirect_to("/admin/categories", :notice => 'Sub Category was successfully created.') }
        else
          format.html { render :action => "edit" }
        end
      else
        if @sub_category.save
          format.html { redirect_to("/admin/categories", :notice => 'Category was successfully created.') }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end

  def edit
    city = get_city

    @category = Category.find(params[:id])
    @categories = Category.where(:category_id => nil, :city => city).order_by("position ASC")
    @activities = Activity.where(:city => city)
    @related_activities = if @category.nil? then [] else @category.activities.map {|j| j._id} end
  end

  def show
    id = params[:id].split('-').first
    @category = Category.find(id)
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.categories.count > 0
      render :json => { "error" => "You can't delete"}, :status => :unprocessable_entity
    else
      @category.destroy
      render :json => { "message" => "ok" }, :status => 201
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.position = params[:category][:position]
    @category.city = params[:category][:city]
    @category.name_translations = {en: params[:english_name], es: params[:spanish_name], pt: params[:portuguese_name]}
    if params[:type] == "children"
      @category.category_image = params[:category][:category_image]
      @category.category_id = params[:category][:category_id]
      @category.activity_ids = params[:related_activities_selector]
    end

    respond_to do |format|
      if @category.save
        format.html { redirect_to("/admin/categories", :notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end

  end
end
