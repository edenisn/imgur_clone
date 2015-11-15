require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  setup do
    @user = users(:user1)
    @image = images(:image1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_includes @response.body, 'Images'
  end

  test "should create image" do
    @request.accept = 'text/javascript'
    assert_difference('Image.count') do
      post :create, image: { name: 'Some name', attachment: fixture_file_upload('/files/test.jpg', 'image/jpg') }
    end

    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @image
    assert_response :success
  end

  test "should not get edit if user not authorized" do
    get :edit, id: @image

    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update image" do
    sign_in @user
    patch :update, id: @image, image: { name: 'new_name', description: 'new_descr' }
    assert_redirected_to image_path(assigns(:image))
  end

  test "should not update image if user not authorized" do
    patch :update, id: @image, image: { name: 'new_name', description: 'new_descr' }

    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should show image" do
    sign_in @user
    get :show, id: @image.id
    assert_response :success
  end

  test "should not show image if user not authorized" do
    get :show, id: @image.id

    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should destroy image" do
    sign_in @user
    assert_difference('Image.count', -1) do
      delete :destroy, id: @image.id
    end
  end

  test "should not destroy image if user not authorized" do
    delete :destroy, id: @image.id

    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
end