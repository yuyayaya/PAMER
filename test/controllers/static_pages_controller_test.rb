require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "PAMER ~学生限定国際交流マッチングアプリ~"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | PAMER ~学生限定国際交流マッチングアプリ~"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | PAMER ~学生限定国際交流マッチングアプリ~"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | PAMER ~学生限定国際交流マッチングアプリ~"
  end
end
