class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, except: :create

  def show
    if @lesson.result.nil?
      @title = t "title.lesson"
    else
      @title = t "title.result"
      @lesson_words = @lesson.lesson_words.answer_not_nil
    end
  end

  def create
    @lesson = current_user.lessons.create params_lesson
    if @lesson
      redirect_to @lesson
    else
      flash[:danger] = t "form.invalid"
      redirect_to categories_path
    end
  end

  def update
    if @lesson.update_attributes(params_lesson) && @lesson.update_attributes(result: remark)
      redirect_to @lesson
    else
      flash[:danger] = t "form.invalid"
      redirect_to root_url
    end
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def params_lesson
    params.require(:lesson).permit :category_id,
      lesson_words_attributes: [:id, :word_answer_id]
  end

  def remark
    word_answer_ids = @lesson.lesson_words.answer_not_nil.map(&:word_answer_id)
    word_answer_ids.empty? ? 0 : WordAnswer.check_correct(word_answer_ids).size
  end
end
