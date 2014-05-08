require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '.col-md-2 a', minimum: 2
    assert_select '.col-md-10 .entry', 3
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
