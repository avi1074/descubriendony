class AdminController < ApplicationController
  # Because there is not users auth is not necesary to use a complex auth
  http_basic_authenticate_with name: "andrea_ji", password: "123admin*2015"

  def index
    redirect_to "/admin/categories"
  end

  def activities
    @city = get_city
    @activities = Activity.where(:city => @city).order_by("main_title ASC")
    @categories = Category.where(:category_id => nil, :city => @city).order_by("position ASC")
  end

  def categories
    @city = get_city
    @categories = Category.where(:category_id => nil, :city => @city).order_by("position ASC")
  end

  def pages
    @city = get_city
    @page = Page.all
  end

  def transportations
    @city = get_city
    @transportation = Transportation.where(:city => @city)
  end

end
