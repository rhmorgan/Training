class SectionsController < ApplicationController

  before_filter :admin_login_required, :only=>['edit', 'list','new','show','create','destroy','index']
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @section_pages, @sections = paginate :sections, :per_page => 10
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      flash[:notice] = 'Section was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = 'Section was successfully updated.'
      redirect_to :action => 'show', :id => @section
    else
      render :action => 'edit'
    end
  end

  def destroy
    Section.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
