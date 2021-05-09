require "test_helper"

class GachasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gacha = gachas(:one)
  end

  test "should get index" do
    get gachas_url
    assert_response :success
  end

  test "should redirect to permanent show page if array items given" do
    get gachas_url, params: { items: ["A", "B", "C"] }
    assert_response :redirect
  end

  test "should redirect to permanent show page if comma splitted items given" do
    get gachas_url, params: { items: "A,B,C" }
    assert_response :redirect
  end

  test "should show gacha" do
    get gacha_url(@gacha), as: :json
    assert_response :success
  end

  test "should destroy gacha" do
    assert_difference('Gacha.count', -1) do
      delete gacha_url(@gacha), as: :json
    end

    assert_response 204
  end
end
