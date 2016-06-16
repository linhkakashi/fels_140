class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words

  before_create :create_words_lesson

  private
  def create_words_lesson
    word_ids = category.words.order("RANDOM()").limit(3).map(&:id)
    self.word_ids = word_ids
  end
end
