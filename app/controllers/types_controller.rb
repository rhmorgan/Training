class TypesController < ApplicationController

  before_filter :admin_login_required, :only=>['edit', 'list','new','show','create','destroy','index']
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @type_pages, @types = paginate :types, :per_page => 10
  end

  def show
    @type = Type.find(params[:id])
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(params[:type])
    if @type.save
      flash[:notice] = 'Type was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @type = Type.find(params[:id])
  end

  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(params[:type])
      flash[:notice] = 'Type was successfully updated.'
      redirect_to :action => 'show', :id => @type
    else
      render :action => 'edit'
    end
  end

  def destroy
    Type.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
