class Admin::QuestionsController < Admin::BaseController
  expose(:questions) { quize.questions }
  expose(:quize)     { Quiz.find(params[:quize_id]) }
  expose(:question)  { quize.questions.find(params[:id]) }

  def index
  end

  def show
  end

  def new
    self.question = Question.new
  end

  def create
    self.question = quize.questions.new(question_params)

    if question.save!
      redirect_to admin_quize_question_url(quize_id: quize.id, id: question.id)
    else
      render 'new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:description, :priority)
  end
end