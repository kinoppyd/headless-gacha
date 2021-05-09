class Gacha < ApplicationRecord
  validates :items, presence: true
  validates :seed, presence: true, numericality: { only_integer: true }

  def gacha
    items.shuffle(random: Random.new(seed.to_i))
  end
end
