require 'test_helper'

class AuthorizedPersonControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get authorized_person_new_url
    assert_response :success
  end

end
