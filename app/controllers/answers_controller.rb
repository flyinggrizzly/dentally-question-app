class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]

  # GET /answers/1 or /answers/1.json
  def show
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers or /answers.json
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to answer_url(@answer), notice: "Answer was successfully created."
    else
      # TODO: figure out how to pass errors back to the Question view here so
      # they render helpfully
      redirect_to @answer.question
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to answer_url(@answer), notice: "Answer was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url, notice: "Answer was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:body, :question_id)
        .merge(answerer: current_user)
    end
end
