# frozen_string_literal: true

require 'test_helper'

class GachasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gacha = gachas(:one)
  end

  test 'should get index' do
    get gachas_url
    assert_response :success
  end

  test 'should redirect to permanent show page if array items given' do
    get gachas_url, params: { items: %w[A B C] }
    assert_response :redirect
  end

  test 'should redirect to permanent show page if comma splitted items given' do
    get gachas_url, params: { items: 'A,B,C' }
    assert_response :redirect
  end

  test 'redirected path has UUID contents id' do
    get gachas_url, params: { items: 'A,B,C' }
    assert @response['Location'].match(%r{/gachas/([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})\Z})
  end

  test 'gacha contents id is different by access' do
    get gachas_url, params: { items: 'A,B,C' }
    id_1 = @response['Location'].match(/([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})\Z/)[0]
    get gachas_url, params: { items: 'A,B,C' }
    id_2 = @response['Location'].match(/([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})\Z/)[0]
    refute_equal id_1, id_2
  end

  test 'returns same items' do
    item1 = 'A'
    item2 = 'B'
    item3 = 'C'
    get gachas_url, params: { items: [item1, item2, item3].join(',') }
    follow_redirect!

    assert_equal JSON.parse(@response.body).sort, [item1, item2, item3].sort
  end

  test 'returns same decoded items when request with URL encoded items' do
    item1 = '@%&'
    item2 = 'B-i-g, g-i-e a.k.a. b.i.g.'
    query = [item1, item2].map { |i| URI.encode_www_form_component(i) }.join(',')
    get gachas_url, params: { items: query }
    follow_redirect!

    shuffled_items = JSON.parse(@response.body)
    assert_equal shuffled_items.sort, [item1, item2].sort
  end

  test 'should show gacha' do
    get gacha_url(@gacha), as: :json
    assert_response :success
  end

  test 'should destroy gacha' do
    assert_difference('Gacha.count', -1) do
      delete gacha_url(@gacha), as: :json
    end

    assert_response 204
  end
end
