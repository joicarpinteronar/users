require 'test_helper'

class TokenInvalidsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @token_invalid = token_invalids(:one)
  end

  test "should get index" do
    get token_invalids_url, as: :json
    assert_response :success
  end

  test "should create token_invalid" do
    assert_difference('TokenInvalid.count') do
      post token_invalids_url, params: { token_invalid: { token: @token_invalid.token } }, as: :json
    end

    assert_response 201
  end

  test "should show token_invalid" do
    get token_invalid_url(@token_invalid), as: :json
    assert_response :success
  end

  test "should update token_invalid" do
    patch token_invalid_url(@token_invalid), params: { token_invalid: { token: @token_invalid.token } }, as: :json
    assert_response 200
  end

  test "should destroy token_invalid" do
    assert_difference('TokenInvalid.count', -1) do
      delete token_invalid_url(@token_invalid), as: :json
    end

    assert_response 204
  end
end
