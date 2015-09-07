class Post < ActiveRecord::Base


belongs_to :user

validates_presence_of :url
validates :url, :format => URI::regexp(%w(http https))

validates :provider, :inclusion => {:in => %w("Mixcloud", "SoundCloud", "Vimeo", "YouTube"), 
		:message => "not a provider" }

extend FriendlyId
 friendly_id :title, use: :slugged

end
