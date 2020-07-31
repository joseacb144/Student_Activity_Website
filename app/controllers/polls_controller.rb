class PollsController < ApplicationController
  layout 'main'
  before_action :authenticate_student!
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :vote]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end


  def vote

    if !@poll.voting_students.include?(current_student)

        vote_opt = params[:option].html_safe
        pollvote_id = params[:pollvote_id].html_safe
        poll_vote=PollVote.find(pollvote_id)
        poll_vote.count +=1
        poll_vote.save

        @poll.voting_students.push(current_student)
        @poll.save
        flash[:notice] = "Thanks for voting."
    else
         flash[:alert] = "You have already voted in this poll."

    end

    redirect_to poll_path(@poll)


  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    @poll.student = current_student

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poll_params
      params.require(:poll).permit(:type, :title, :description, :start_dt, :end_dt, :status, :option)
    end
end
