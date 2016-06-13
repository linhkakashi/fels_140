class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :verify_user

  def show
    @word = Word.find_by id: params[:id]
    @word_answers = @word.word_answers
  end

  def new
    @word = Word.new
    @category = Category.find_by id: params[:id]
    Settings.MIN_ANSWER_NUMBER.times{@word.word_answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "notice.create_word_success"
      redirect_to admin_category_path @word.category
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
