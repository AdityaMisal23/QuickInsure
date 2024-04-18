require "test_helper"

class TheaterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get theater_index_url
    assert_response :success
  end
end
