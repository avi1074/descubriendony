class PagesController < ApplicationController
 before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json

  # GET /pages/1
  # GET /pages/1.json
  def show
    @varcity = params[:city]
  end

  # GET /pages/new
  def new
     @page = Page.new
  end

  # GET /pages/1/edit
  def edit
   @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    
    respond_to do |format|
      if @page.save
        format.html { redirect_to("/admin/pages" , notice: 'Page was successfully created.') }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page = Page.find(params[:id])
    #@page.page = page_params[:page]
  
    @page.content_translations = {en: params[:english_content], es: params[:spanish_content], pt: params[:portuguese_content]}
     
      respond_to do |format|
      if @page.save
        format.html { redirect_to("/admin/pages", notice: 'Page was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
    
   end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
  
  def about_us
     @page = Page.where(page: 'about_us').where(city: "#{@city_id}").first
  end

  def faqs
    @page = Page.where(page: 'faq').where(city: "#{@city_id}").first
  end

  def landing
    @page = Page.where(page: 'landing').where(city: "#{@city_id}").first
  end

  def thankyou
    @page = Page.where(page: 'thankyou').where(city: "#{@city_id}").first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
     @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:page, :city)
    end
end
