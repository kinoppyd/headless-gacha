class GachasController < ApplicationController
  before_action :set_gacha, only: [:show, :destroy]

  def index
    items = parse_items
    if items
      gacha = Gacha.create!(items: items, seed: seed)
      redirect_to gacha
    else
      render json: []
    end
  end

  def show
    render json: @gacha.gacha
  end

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

    def seed
      Random.new_seed
    end

    def parse_items
      return if !params[:items] || params[:items].blank?

      items = params[:items]
      return items if items.kind_of?(Array)

      items.include?(",") ? items.split(",") : Array(items)
    end
end
