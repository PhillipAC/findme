class MatchesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.select { |match| match.finder_id == current_user.id }
  end
  
  def index_mine
    @matches = Match.select { |match| match.targetet_id == current_user.id }
  end
  
  def index_all
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new match_params
    @match.target = current_user
    respond_to do |format| 
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST
  def get_distance
    x_1 = params[:x_coord]
    y_1 = params[:y_coord]
    @match = Match.find(params[:id])
    distance = (x_1.to_f - @match.target_x)**2+(y_1.to_f - @match.target_y)**2
    if @match.distance
      if @match.distance < distance
        level = "colder"
      end
      if @match.distance > distance
        level = "hotter"
      end
      if distance < 3e-9
        level = "ON FIRE!"
      end
    else
      level = "move"
    end
    @match.update(distance: distance)
    render :json => { :distance => distance, :level => level }
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:target_x, :target_y, :target_z, :finder_id)
    end
end
