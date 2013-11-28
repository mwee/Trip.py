require 'test_helper'

class TripInvitationsControllerTest < ActionController::TestCase
  setup do
    @trip_invitation = trip_invitations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trip_invitations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip_invitation" do
    assert_difference('TripInvitation.count') do
      post :create, trip_invitation: {  }
    end

    assert_redirected_to trip_invitation_path(assigns(:trip_invitation))
  end

  test "should show trip_invitation" do
    get :show, id: @trip_invitation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip_invitation
    assert_response :success
  end

  test "should update trip_invitation" do
    patch :update, id: @trip_invitation, trip_invitation: {  }
    assert_redirected_to trip_invitation_path(assigns(:trip_invitation))
  end

  test "should destroy trip_invitation" do
    assert_difference('TripInvitation.count', -1) do
      delete :destroy, id: @trip_invitation
    end

    assert_redirected_to trip_invitations_path
  end
end
