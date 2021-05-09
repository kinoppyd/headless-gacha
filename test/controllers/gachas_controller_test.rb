require "test_helper"

class GachasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gacha = gachas(:one)
  end

  test "should get index" do
    get gachas_url, as: :json
    assert_response :success
  end

  test "should create gacha" do
    assert_difference('Gacha.count') do
      post gachas_url, params: { gacha: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show gacha" do
    get gacha_url(@gacha), as: :json
    assert_response :success
  end

  test "should update gacha" do
    patch gacha_url(@gacha), params: { gacha: {  } }, as: :json
    assert_response 200
  end

  test "should destroy gacha" do
    assert_difference('Gacha.count', -1) do
      delete gacha_url(@gacha), as: :json
    end

    assert_response 204
  end
end
