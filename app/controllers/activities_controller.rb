class ActivitiesController < ApplicationController
  # Because there is not users auth is not necesary to use a complex auth
  http_basic_authenticate_with name: "andrea_ji", password: "123admin*2015", except: [:index, :show, :search]

  def index
    @categories = Category.where(:city => Rails.application.config.city, :category_id => nil).order_by("position ASC")
  end

  def show
    id = params[:id].split('-').first
    @activity = Activity.find(id)

    @parent_category = Category.find(params[:category_id])
    @related_activities_same_category = @parent_category.activities.ne("_id" => @activity.id.to_s)
    @related_activities_by_group = @activity.related_activities.group_by { |s| Category.find(s.principal_category.to_s).category rescue Category.first }

    # SEO
    @page_title = @activity.main_title
    @page_description = @activity.meta_description
    @page_keywords = @activity.meta_keywords
  end


  def new
    @activity = Activity.new
  end

  def create
    @city = session[:city]
    @activity = Activity.new(:main_title => params[:main_title], city: @city)
    respond_to do |format|
      if @activity.save
        format.html { redirect_to root_path, :notice => 'Activity created !!' }
        format.js { render :json => {:activity => @activity.as_json(:only => [:_id])},
                                     content_type: 'text/json' }
      else
        format.json { render :json => { :errors => @activity.errors.full_messages}, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @city = get_city
    @activity = Activity.find(params[:id])
    @categories = Category.where(:category_id => nil, :city => @city).order_by("position ASC")
    @activities = Activity.where(:city => @city)
  end

  def update
    @activity = Activity.find(params[:id])
    @activity.position = activity_params[:position]
    @activity.main_title = activity_params[:main_title]
    @activity.title_translations = {en: params[:english_title], es: params[:spanish_title], pt: params[:portuguese_title]}
    @activity.video_translations = {en: params[:english_video], es: params[:spanish_video], pt: params[:portuguese_video]}
    @activity.meta_title_translations = {en: params[:english_meta_title], es: params[:spanish_meta_title], pt: params[:portuguese_meta_title]}
    @activity.meta_keywords_translations = {en: params[:english_meta_keywords], es: params[:spanish_meta_keywords], pt: params[:portuguese_meta_keywords]}
    @activity.meta_description_translations = {en: params[:english_meta_description], es: params[:spanish_meta_description], pt: params[:portuguese_meta_description]}
    @activity.description_translations = {en: params[:english_description], es: params[:spanish_description], pt: params[:portuguese_description]}
    @activity.url = activity_params[:url]
    @activity.address = activity_params[:address]
    @activity.address2 = activity_params[:address2]
    @activity.phone_number = activity_params[:phone_number]
    @activity.is_free = activity_params[:is_free]
    @activity.price = activity_params[:price]
    @activity.pricechange_translations = {en: params[:english_change], es: params[:spanish_change], pt: params[:portuguese_change]}
    @activity.city = activity_params[:city]
    @activity.activity_image = activity_params[:activity_image]
    @activity.google_maps = activity_params[:google_maps]
    @activity.coordinates = params[:coordinates].split(',')
    @activity.category_id = activity_params[:category_id]
    @activity.banner_url = activity_params[:banner_url]
    @activity.banner_vertical = activity_params[:banner_vertical]
    @activity.banner_horizontal = activity_params[:banner_horizontal]
    @activity.related_activity_ids = params[:related_activities_selector]
    @activity.buy_now_url = activity_params[:buy_now_url]
    @activity.menu_url = activity_params[:menu_url]
    @activity.bannerurlchange_translations = {en: params[:english_bannerurl], es: params[:spanish_bannerurl], pt: params[:portuguese_bannerurl]}
    @activity.bannerverticalchange_translations = {en: params[:english_bannervertical], es: params[:spanish_bannervertical], pt: params[:portuguese_bannervertical]}
    @activity.bannerhorizontalchange_translations = {en: params[:english_bannerhorizontal], es: params[:spanish_bannerhorizontal], pt: params[:portuguese_bannerhorizontal]}
    @activity.buynowurlchange_translations = {en: params[:english_buynow], es: params[:spanish_buynow], pt: params[:portuguese_buynow]}
    @activity.transportations = activity_params[:transportation_ids]
    if params[:transportation_ids]
      params[:transportation_ids].each do |ti|
        @activity.transportations.push(Transportation.find(ti))
      end
    end



    respond_to do |format|
      if @activity.save
        format.html { redirect_to("/admin/activities?city=#{activity_params[:city]}", :notice => 'Activity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end

  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    render :json => { "message" => "ok" }, :status => 201
  end

  def search
    @activities = Activity.where("main_title" => /#{params[:searchterm]}/i).where(city: "#{@city_id}")
  end

  private

  def activity_params
    params.require(:activity).permit(:main_title,
                                     :position,
                                     :url,
                                     :address,
                                     :address2,
                                     :phone_number,
                                     :is_free, :price,
                                     :city,
                                     :transportation_ids,
                                     :activity_image,
                                     :google_maps,
                                     :coordinates,
                                     :category_id,
                                     :banner_url,
                                     :banner_vertical,
                                     :banner_horizontal,
                                     :buy_now_url,
                                     :menu_url)
  end
end
