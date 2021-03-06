require File.dirname(__FILE__) + '/../test_helper'
require 'deliverables_controller'

# Re-raise errors caught by the controller.
class DeliverablesController; def rescue_action(e) raise e end; end

class DeliverablesControllerTest < Test::Unit::TestCase
  fixtures :deliverables

  def setup
    @controller = DeliverablesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = deliverables(:first).id
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

    assert_not_nil assigns(:deliverables)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:deliverable)
    assert assigns(:deliverable).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:deliverable)
  end

  def test_create
    num_deliverables = Deliverable.count

    post :create, :deliverable => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_deliverables + 1, Deliverable.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:deliverable)
    assert assigns(:deliverable).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Deliverable.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Deliverable.find(@first_id)
    }
  end
end
