# frozen_string_literal: true

#
# Gacha
#
class Gacha < ApplicationRecord
  include UuidPrimaryKey

  serialize :items, ActiveRecord::Coders::JSON

  validates :items, presence: true
  validate :items_not_empty
  validates :seed, presence: true, numericality: { only_integer: true }

  def gacha
    items.shuffle(random: Random.new(seed.to_i))
  end

  private

  def items_not_empty
    errors.add(:items, 'Items must not be blank') if items.blank?
  end
end
