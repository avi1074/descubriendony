class TransportationsController < ApplicationController
  before_action :set_transportation, only: [:show, :edit, :update, :destroy]

  # GET /transportations
  # GET /transportations.json
  def index
    city = get_city
    @transportations = Transportation.where(city: city)
  end

  # GET /transportations/1
  # GET /transportations/1.json
  def show
  end

  # GET /transportations/new
  def new
    city = get_city
    @transportation = Transportation.new(city: city)

  end

  # GET /transportations/1/edit
  def edit
    city = get_city
    @lines = Line.where(city: city)
  end

  # POST /transportations
  # POST /transportations.json
  def create
    city = get_city
    @transportation = Transportation.new(transportation_params)
    @transportation.city = city

    respond_to do |format|
      if @transportation.save
        format.html { redirect_to("/admin/transportations?city=#{city}", notice: 'Transportation was successfully created.' ) }
        format.json { render action: 'show', status: :created, location: @transportation }
      else
        format.html { render action: 'new' }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportations/1
  # PATCH/PUT /transportations/1.json
  def update
     @transportation = Transportation.find(params[:id])
     @transportation.name = transportation_params[:name]
     @transportation.transport_type = transportation_params[:transport_type]
     @transportation.city = get_city
     @transportation.lines = transportation_params[:line_ids]
    if params[:line_ids]
      params[:line_ids].each do |ti|
        @transportation.lines.push(Line.find(ti))
      end
    end

    respond_to do |format|
      if @transportation.update
        format.html { redirect_to("/admin/transportations", notice: 'Transportation was successfully updated.' ) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportations/1
  # DELETE /transportations/1.json
 def destroy
    @transportation = Transportation.find(params[:id])
    @transportation.destroy
    render :json => { "message" => "ok" }, :status => 201
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportation
      @transportation = Transportation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transportation_params
      params.require(:transportation).permit(:name, :transport_type, :city, :line_ids)
    end
end
