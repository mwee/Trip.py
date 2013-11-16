require 'test_helper'

class FreerangesControllerTest < ActionController::TestCase
  setup do
    @freerange = freeranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:freeranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create freerange" do
    assert_difference('Freerange.count') do
      post :create, freerange: { end_date: @freerange.end_date, start_date: @freerange.start_date }
    end

    assert_redirected_to freerange_path(assigns(:freerange))
  end

  test "should show freerange" do
    get :show, id: @freerange
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @freerange
    assert_response :success
  end

  test "should update freerange" do
    patch :update, id: @freerange, freerange: { end_date: @freerange.end_date, start_date: @freerange.start_date }
    assert_redirected_to freerange_path(assigns(:freerange))
  end

  test "should destroy freerange" do
    assert_difference('Freerange.count', -1) do
      delete :destroy, id: @freerange
    end

    assert_redirected_to freeranges_path
  end
end
