class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer

  scope :answer_not_nil, ->{where.not word_answer_id: nil}
end
