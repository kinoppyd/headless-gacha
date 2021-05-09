require "test_helper"

class GachaTest < ActiveSupport::TestCase
  def setup
    @items = ('A'..'Z').to_a.shuffle
    @seed = Random.new_seed
  end

  test "gacha returns shuffled array" do
    gacha = Gacha.create!(items: @items, seed: @seed)
    assert_not_equal @items, gacha.gacha
  end

  test "gacha returns same result when same items and seed given" do
    gacha_1 = Gacha.create!(items: @items, seed: @seed)
    gacha_2 = Gacha.create!(items: @items, seed: @seed)
    assert_equal gacha_1.gacha, gacha_2.gacha
  end

  test "gacha returns not same result when same items and not same seed given" do
    gacha_1 = Gacha.create!(items: @items, seed: @seed)
    gacha_2 = Gacha.create!(items: @items, seed: Random.new_seed)
    assert_not_equal gacha_1.gacha, gacha_2.gacha
  end

  test "items have more than 1 item" do
    assert Gacha.create(items: ["A"], seed: @seed).valid?
  end

  test "items must have more than 1 item" do
    assert_not Gacha.create(items: [], seed: @seed).valid?
  end

  test "seed as numerical string" do
    assert Gacha.create(items: @items, seed: '12345').valid?
  end

  test "seed must be numerical string" do
    assert_not Gacha.create(items: @items, seed: 'not numeric string').valid?
  end
end
