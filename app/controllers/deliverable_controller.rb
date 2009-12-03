class DeliverableController < ApplicationController

  before_filter :admin_login_required, :only=>['edit', 'list','new','show','create','destroy','index']
#  before_filter :login_required
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @deliverable_pages, @deliverables = paginate :deliverables, :per_page => 10
  end

  def show
    @deliverable = Deliverable.find(params[:id])
  end

  def new
    @deliverable = Deliverable.new
  end

  def create
    @deliverable = Deliverable.new(params[:deliverable])
    if @deliverable.save
      flash[:notice] = 'Deliverable was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @deliverable = Deliverable.find(params[:id])
  end

  def update
    @deliverable = Deliverable.find(params[:id])
    if @deliverable.update_attributes(params[:deliverable])
      flash[:notice] = 'Deliverable was successfully updated.'
      redirect_to :action => 'show', :id => @deliverable
    else
      render :action => 'edit'
    end
  end

  def destroy
    Deliverable.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
