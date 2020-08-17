require 'test_helper'

class ParentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get parents_new_url
    assert_response :success
  end

end
