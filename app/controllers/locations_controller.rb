class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :user_is_finder_or_target, only: [:show]

  # GET /locations
  # GET /locations.json
  def index
    @finder_locations = Location.select { |location| location.finder_id == current_user.id }
    @target_locations = Location.select { |location| location.target_id == current_user.id }
  end
  
  def index_all
    redirect_to(root_url)
    @locations = Location.all
  end

  # GET /Location/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new location_params
    @location.target = current_user
    respond_to do |format| 
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST
  def get_distance
    x_1 = params[:x_coord]
    y_1 = params[:y_coord]
    @location = Location.find(params[:id])
    distance = (x_1.to_f - @location.target_x)**2+(y_1.to_f - @location.target_y)**2
    if @location.startDistance == nil
      @location.update(startDistance: distance)
    end
    if @location.distance
      if @location.distance <= distance
        level = "colder"
      end
      if @location.distance > distance
        level = "hotter"
      end
    else
      level = "move"
    end
    @location.update(distance: distance)
    initial = @location.startDistance 
    percentage = (100*(initial - distance)/(initial)).round
    render :json => { :initial => initial,
                      :distance => distance, 
                      :level => level, 
                      :percentage => percentage }
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#-------------------------------

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:target_x, :target_y, :target_z, :finder_id, :name)
    end
    
    def user_is_finder_or_target
      @location = Location.find(params[:id])
      redirect_to(root_url) unless current_user.id == @location.finder_id || current_user == @location.target
    end
end
