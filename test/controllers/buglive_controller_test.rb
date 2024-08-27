require "test_helper"

class BugliveControllerTest < ActionDispatch::IntegrationTest
  test "should get suggestions" do
    get buglive_suggestions_url
    assert_response :success
  end
end
