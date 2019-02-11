require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "PAMER ~学生限定国際交流マッチングアプリ~"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

end
