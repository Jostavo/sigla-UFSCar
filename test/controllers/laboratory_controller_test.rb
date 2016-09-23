require 'test_helper'

class LaboratoryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get laboratory_show_url
    assert_response :success
  end

end
