require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get suggestion" do
    get search_suggestion_url
    assert_response :success
  end
end
