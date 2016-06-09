class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :verify_user
  before_action :load_category, except: [:index, :new, :create]

  def index
    @categories = Category.paginate(page: params[:page]).per_page Settings["PAGE_SIZE"]
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "notice.create_category_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "notice.update_category_success"
      redirect_to admin_category_path @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "notice.deleted_category_success"
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
