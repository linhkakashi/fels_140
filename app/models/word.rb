class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words
  accepts_nested_attributes_for :word_answers, allow_destroy: true

  validates :content, presence: true, length: {maximum: 15}

  scope :all_words, ->(user_id, category_ids){where category_id: category_ids}

  scope :learned_words, ->(user_id, category_ids){joins(lesson_words: :lesson)
    .where category_id: category_ids, lessons: {user_id: user_id}}

  scope :not_learn_words, ->(user_id, category_ids){where(category_id: category_ids)
    .where.not id: learned_words(user_id, category_ids)}
end
