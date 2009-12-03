class ResultController < ApplicationController

  before_filter :login_required, :only=>['evaluation', 'index', 'update']

  def evaluation    
    @user=session[:user]
    @student = params[:id]
    @results = Result.find(:all, :conditions=>["student_id=? and user_id=?",params[:id],@user.id])
    session[:student] = params[:id]
    
    puts "student"
    puts session[:student]
    
  end

  def update

    puts "student"
    puts session[:student]


    if params.nil?
       puts "IS Null"
    else   
       puts "Not Null"
    end    
    
          
    @user_id  = session[:user]
    @testme = params[:result]
    @comment_params = params[:comments]
#   Deletes old results
    @testr = Result.find(:all, :conditions=>["student_id=? and user_id=?",session[:student],@user_id.id])
    for rec in @testr
      Result.find(rec.id).destroy
    end

#   Deletes old comments
    @commentary = Comment.find(:all, :conditions=>["student_id=? and user_id=?",session[:student],@user_id.id])
    for comm in @commentary
      Comment.find(comm.id).destroy
    end
    
  if @testme.nil?
  else  
  #   Appends new results    
    for del in @testme["deliverable_ids"] ||=[]
      puts "Deliverable:"
      puts del
      @result = Result.new
      @result.deliverable_id = del
      @result.user_id = @user_id.id
      @result.student_id = session[:student] #@testme["student_id"]
      @result.save
     if @result.save
        flash[:notice] = 'Result was successfully created.'
   #       redirect_to :action => 'tryagain'
        else
   #       render :action => 'tryagain'
        end
      end
  end

  if @comment_params.nil?
  else  
#   Appends new comments  
    for comment in @comment_params
      puts "Comment_Section:"
      puts comment[0].to_i    
      @c = Comment.new
      @c.exercise_id = comment[0].to_i
      @c.user_id = @user_id.id
      @c.student_id = session[:student] #@testme["student_id"]
      @c.comments = comment[1]
      @c.save
    end
  end

#    if @result.save
#      flash[:notice] = 'Result was successfully created.'
#      redirect_to :action => 'tryagain'
#    else
      render :action => 'index'
#    end

  end

  def list
    @result_pages, @results = paginate :results, :per_page => 10
  end

  
  def index
    list
    render :action => 'index'
  end

  def scorecard
    
  @detailed_completion_matrix = Exercise.find_by_sql(["SELECT * 
            FROM result_detailed_matrix_03_vw
            WHERE student_id = ?", params[:id]])
 
  @summary_completion_matrix = Exercise.find_by_sql(["SELECT * 
                                                    FROM result_summary_matrix_03_vw
                                                    WHERE student_id = ?", params[:id]]) 

  end

end

