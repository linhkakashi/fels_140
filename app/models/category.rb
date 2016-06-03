class Category < ActiveRecord::Base
  has_many :words

  validates :name, presence: true, length: {maximum: 45}
end
