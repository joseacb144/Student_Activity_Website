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
