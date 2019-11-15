class Admin::QuizesController < Admin::BaseController
  expose(:quizes)    { Quiz.all }
  expose(:quiz)      { Quiz.find(params[:id]) }
  expose(:questions) { quiz.questions }

  def index
  end

  def show
  end

  def new
    self.quiz = Quiz.new
  end

  def create
    self.quiz = Quiz.new(quiz_params)

    if quiz.save!
      redirect_to admin_quiz_url(quiz)
    else
      render 'new'
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, :priority)
  end
end