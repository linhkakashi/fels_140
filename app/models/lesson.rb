class Lesson < ActiveRecord::Base
  include CreateActivity

  belongs_to :category
  belongs_to :user
  has_many :lesson_words

  after_create :create_lesson_activity

  private
  def create_lesson_activity
    create_activity self.user_id, self.id, Settings["start_lesson"]
  end
end
