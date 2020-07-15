class StudentsController <  Devise::RegistrationsController
  layout 'main'
  before_action :authenticate_student!

  # GET /students
  # GET /students.json
  def index
    logger.info "landed index"
    if !student_signed_in?
      flash[:notice] ="Please Sign in."
      redirect_to root_path
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
      super

  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
      super
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    super
  end

  def search

  end

  def find

     if params[:query] || params[:department]
      query = params[:query].html_safe
      department = params[:department].html_safe
      if !department.blank?
        @users = Student.any_of({ :first_name => /#{query}/ }, {:last_name => /#{query}/ }).and({:department => /#{department}/ })
      else
        @users = Student.any_of({ :first_name => /#{query}/ }, {:last_name => /#{query}/ })
      end

      logger.info "found "+@users.size.to_s
    end

    respond_to do |format|
      format.json {@users}
      format.js { render json: @users.to_json}
      format.html{ render :inline => "<br>"}
    end

  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :address, :city, :state, :zip_code, :email, :login_id)
    end
end
