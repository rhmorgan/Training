require File.dirname(__FILE__) + '/../test_helper'
require 'sections_controller'

# Re-raise errors caught by the controller.
class SectionsController; def rescue_action(e) raise e end; end

class SectionsControllerTest < Test::Unit::TestCase
  fixtures :sections

  def setup
    @controller = SectionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = sections(:first).id
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

    assert_not_nil assigns(:sections)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:section)
    assert assigns(:section).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:section)
  end

  def test_create
    num_sections = Section.count

    post :create, :section => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_sections + 1, Section.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:section)
    assert assigns(:section).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Section.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Section.find(@first_id)
    }
  end
end
