class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    if params[:category_id].nil?
      params[:word_type] = Settings["all"]
      @words = Word.paginate(page: params[:page]).per_page Settings["WORD_PAGE_SIZE"]
    else
      @words = Word.send("#{type}_words", current_user.id, category_ids)
        .paginate(page: params[:page]).per_page Settings["WORD_PAGE_SIZE"]
    end
  end

  private
  def type
    params[:word_type] == Settings["not learn"] ? Settings["not_learn"] : params[:word_type]
  end

  def category_ids
    params[:category_id].blank? ? Category.all.map(&:id) : params[:category_id]
  end
end
