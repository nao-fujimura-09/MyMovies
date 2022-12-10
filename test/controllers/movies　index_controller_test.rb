require "test_helper"

class Movies　indexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get movies　index_show_url
    assert_response :success
  end

  test "should get search" do
    get movies　index_search_url
    assert_response :success
  end
end
