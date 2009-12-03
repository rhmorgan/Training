class SetupController < ApplicationController

before_filter :admin_login_required, :only=>['defaults', 'index']

def updatesetup
  
  @setup_params = params[:setup]
#  @section = params[:section_id]

#  puts "Course"
#  puts @setup_params["course_id"]

  @setup_rec = Setup.find(:all)
  
  for rec in @setup_rec
    Setup.find(rec.id).destroy
  end

  @setup = Setup.new
  @setup.section_id = @setup_params["section_id"]
  @setup.course_id = @setup_params["course_id"]
  @setup.save
  
  render :action => 'index'
  end
end

def defaults 
end