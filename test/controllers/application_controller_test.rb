require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get application_about_url
    assert_response :success
  end

end
