class GachasController < ApplicationController
  before_action :set_gacha, only: [:show, :update, :destroy]

  # GET /gachas
  def index
    @gachas = Gacha.all

    render json: @gachas
  end

  # GET /gachas/1
  def show
    render json: @gacha
  end

  # POST /gachas
  def create
    @gacha = Gacha.new(gacha_params)

    if @gacha.save
      render json: @gacha, status: :created, location: @gacha
    else
      render json: @gacha.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gachas/1
  def update
    if @gacha.update(gacha_params)
      render json: @gacha
    else
      render json: @gacha.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gachas/1
  def destroy
    @gacha.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gacha
      @gacha = Gacha.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gacha_params
      params.fetch(:gacha, {})
    end
end
