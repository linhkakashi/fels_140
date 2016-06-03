class WordAnswer < ActiveRecord::Base
  has_many :lesson_words
  belongs_to :word

  validates :content, presence: true, length: {maximum: 20}
end
