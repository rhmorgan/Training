class UserController < ApplicationController

#  before_filter :login_required, :only=>['welcome', 'hidden']
  before_filter :admin_login_required, :only=>['delete', 'change_password', 'edit', 'forgot_password', 'list', 'show','signup','index', 'destroy', 'update','welcome', 'hidden']

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(@params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'list' #, :id => @type
    else
      render :action => 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def signup
    @user = User.new(@params[:user])
    if request.post?  
      if @user.save
        session[:user] = User.authenticate(@user.login, @user.password)
        flash[:message] = "Signup successful"
#        redirect_to :action => "welcome"          
        redirect_to :action => "list"          
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
#        redirect_to_stored
        if session[:user].role_id ==2
           redirect_to :controller=>'setup', :action=>'index'
        else
           redirect_to :controller=>'result', :action=>'index'          
        end
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:message]="Password Changed"
      end
    end
  end

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def welcome
      @user=session[:user]
  end
  
  def hidden
  end
end