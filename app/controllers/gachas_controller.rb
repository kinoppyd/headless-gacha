# frozen_string_literal: true

#
# GachaController
#
class GachasController < ApplicationController
  before_action :set_gacha, only: %i[show destroy]

  def index
    items = parse_items
    if items
      gacha = Gacha.create!(items: items, seed:)
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
    array_items&.map { |i| URI.decode_www_form_component(i) }
  end

  def array_items
    return if !params[:items] || params[:items].blank?

    items = params[:items]
    return items if items.is_a?(Array)

    items.include?(',') ? items.split(',') : Array(items)
  end
end
