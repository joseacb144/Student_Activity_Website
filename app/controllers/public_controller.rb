class PublicController < ApplicationController

  layout 'application'

  def index
      redirect_to new_student_session_path
     
  end

  def show
    

  end

  def about

  end
  

  private

  def setup_navigation
 
  end


end
