require 'test_helper'

class HelpsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get helps_new_url
    assert_response :success
  end

end
