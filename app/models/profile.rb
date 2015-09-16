class Profile < ActiveRecord::Base

paginates_per 10
 mount_uploader :image, ImageUploader
 has_one :user
 belongs_to :user

 def username
  	self.user.name
  end

 extend FriendlyId
  friendly_id :username, use: :slugged

  # has_many :posts, through: :user, counter_cache: true
  # default_scope { order("posts DESC") }

end
