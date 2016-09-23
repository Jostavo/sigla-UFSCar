require 'test_helper'

class StatusControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get status_new_url
    assert_response :success
  end

end
