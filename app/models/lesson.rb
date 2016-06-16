class Lesson < ActiveRecord::Base
  include CreateActivity

  belongs_to :category
  belongs_to :user
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words

  after_create :create_lesson_activity
  before_create :create_words_lesson

  private
  def create_lesson_activity
    create_activity self.user_id, self.id, Settings["start_lesson"]
  end

  def create_words_lesson
    word_ids = category.words.order("RANDOM()").limit(Settings["QUESTION_NUMBERS"]).map(&:id)
    self.word_ids = word_ids
  end
end
