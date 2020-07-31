class EventsController < ApplicationController
  layout 'main'
  before_action :authenticate_student!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :unattend_event, :attend_event]
  before_action :verify_status, only: [:unattend_event, :attend_event]
  # GET /events
  # GET /events.json
  def index
    @events = current_student.events
    @dateFormat = t'date.format.short'
    if params[:start_dt] && !params[:start_dt].blank?
      date_param = params[:start_dt].html_safe
      end_dt = date_param.to_date.end_of_month
      @attending = current_student.attending_events.where({:start_dt => { :$gte => date_param}, :end_dt => { :$lte => end_dt} })
      @result_dt = date_param.to_date 
    else
      @attending = current_student.attending_events.where({:start_dt => { :$gte => DateTime.now.beginning_of_month}, :end_dt => { :$lte => DateTime.now.end_of_month} })
      @result_dt = DateTime.now 
    end
    logger.info "attending size: "+@attending.size.to_s

    rescue StandardError => ex
       puts "Rescued: #{ex.inspect}"
       puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"
        @events = current_student.events
        @dateFormat = t'date.format.short'
        @attending = current_student.attending_events
  end

  # GET /events/1
  # GET /events/1.json
  def show

    @already_attending =current_student.attending_events.include?(@event)


  end

  # GET /events/new
  def new
    @event = Event.new
    @event.student =current_student
  end


  def search
    @attending = current_student.attending_events
    gon.attending = @attending


  end


  def events_search
     respond_to do |format|
       if !params[:start_dt].blank? 
        start_dt = params[:start_dt].html_safe
        if !params[:end_dt].blank?
          end_dt = params[:end_dt].html_safe
          @events = Event.where({:start_dt => { :$gte => Date.strptime(start_dt, '%m/%d/%Y') }, :end_dt => { :$lte => Date.strptime(end_dt,'%m/%d/%Y') } })
        else
          @events = Event.where({:start_dt => { :$gte => Date.strptime(start_dt, '%m/%d/%Y') }})
        end

        logger.info "found "+@events.size.to_s
      end
     
        format.json {@events}
        format.js { render json: @events.to_json}
        format.html{ render :inline => "<br>"}
      end
  end

  def attend_event
    logger.info "title "+@event.to_s
    current_student.attending_events.push(@event)
    @event.attending_students.push(current_student)

    if current_student.save && @event.save
      logger.info "Events size "+current_student.attending_events.size.to_s
      flash[:notice]= "You are now attending "+@event.title
    else
      logger.info "Error Saving " +@event.title
      logger.info "errors "+ current_student.errors.full_messages.to_s
     
      flash[:alert]= "Error Saving " +@event.title
    end
    redirect_to events_path

  end

  def unattend_event
    
    current_student.attending_events.delete(@event)
    @event.attending_students.delete(current_student)

    if current_student.save &&  @event.save
      logger.info "Events size "+current_student.attending_events.size.to_s
      flash[:notice]= "You are not attending  "+@event.title
    else
      logger.info "Error deleting " +@event.title
      logger.info "errors "+@event.errors.full_messages.to_s
      flash[:alert]= "Error deleting " +@event.title
    end

    redirect_to events_path

  end
    

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    @event.student=current_student

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    logger.info "*******STARTDT "+event_params[:start_dt].to_s
    logger.info "end_dt "+event_params[:end_dt].to_s

    if event_params[:start_dt]
      logger.info "Changed start date"
      event_params[:start_dt] = event_params[:start_dt].to_s.mongoize
    end

    if event_params[:end_dt]
      event_params[:end_dt] = event_params[:end_dt].to_s.mongoize
    end
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      logger.info "id "+params[:id].to_s
      logger.info "event_id "+params[:event_id].to_s
      
      @event = Event.find( params[:id] ? params[:id]: params[:event_id])
       @dateFormat = t'date.format.short'
    end

    def verify_status
      if @event.status =='inactive' || @event.end_dt <= DateTime.now
        flash[:alert] = "Event is inactive or in past."
        redirect_to events_path
      end 
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:type, :title, :description, :start_dt, :end_dt, :status , :address, events_attributes: Event.attribute_names.map(&:to_sym).push(:_destroy))
    end
end
