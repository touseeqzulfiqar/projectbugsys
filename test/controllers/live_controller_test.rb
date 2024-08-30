require "test_helper"

class LiveControllerTest < ActionDispatch::IntegrationTest
  test "should get suggestions" do
    get live_suggestions_url
    assert_response :success
  end
end
