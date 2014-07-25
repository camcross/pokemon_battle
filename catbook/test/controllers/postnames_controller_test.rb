require 'test_helper'

class PostnamesControllerTest < ActionController::TestCase
  setup do
    @postname = postnames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:postnames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create postname" do
    assert_difference('Postname.count') do
      post :create, postname: { body: @postname.body, name: @postname.name }
    end

    assert_redirected_to postname_path(assigns(:postname))
  end

  test "should show postname" do
    get :show, id: @postname
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @postname
    assert_response :success
  end

  test "should update postname" do
    patch :update, id: @postname, postname: { body: @postname.body, name: @postname.name }
    assert_redirected_to postname_path(assigns(:postname))
  end

  test "should destroy postname" do
    assert_difference('Postname.count', -1) do
      delete :destroy, id: @postname
    end

    assert_redirected_to postnames_path
  end
end
