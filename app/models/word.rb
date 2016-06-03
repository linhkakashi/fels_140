class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers

  validates :content, presence: true, length: {maximum: 15}
end
