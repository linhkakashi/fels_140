class Activity < ActiveRecord::Base
  belongs_to :user

  def load_lesson
    Lesson.find_by id: self.target_id
  end

  def load_user
    User.find_by id: self.target_id
  end
end
