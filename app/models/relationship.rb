class Relationship < ActiveRecord::Base
  include CreateActivity

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :create_activity_follow
  before_destroy :create_activity_unfollow

  private
  def create_activity_follow
    create_activity self.follower_id, self.followed_id, Settings["follow"]
  end

  def create_activity_unfollow
    create_activity self.follower_id, self.followed_id, Settings["unfollow"]
  end
end
