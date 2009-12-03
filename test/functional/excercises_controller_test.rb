require File.dirname(__FILE__) + '/../test_helper'
require 'excercises_controller'

# Re-raise errors caught by the controller.
class ExcercisesController; def rescue_action(e) raise e end; end

class ExcercisesControllerTest < Test::Unit::TestCase
  fixtures :excercises

  def setup
    @controller = ExcercisesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = excercises(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:excercises)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:excercise)
    assert assigns(:excercise).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:excercise)
  end

  def test_create
    num_excercises = Excercise.count

    post :create, :excercise => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_excercises + 1, Excercise.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:excercise)
    assert assigns(:excercise).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Excercise.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Excercise.find(@first_id)
    }
  end
end
