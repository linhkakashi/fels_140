class LessonsController < ApplicationController
  before_action :logged_in_user

  def show
    @lesson = Lesson.find_by id: params[:id]
    @title = @lesson.result.nil? ? t("title.lesson") : t("title.result")
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
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.update_attributes params_lesson
      redirect_to @lesson
    else
      flash[:danger] = t "form.invalid"
      redirect_to root_url
    end
  end

  private
  def params_lesson
    params.require(:lesson).permit :category_id, lesson_words_attributes: [:id, :word_answer_id]
  end
end
