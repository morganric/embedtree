class Post < ActiveRecord::Base


belongs_to :user
paginates_per 6	

acts_as_taggable

validates_presence_of :url
validates :url, :format => URI::regexp(%w(http https))

validates_inclusion_of :provider, :in => ["Mixcloud", "SoundCloud", "Vimeo", "YouTube", "TED"], 
		:message => "not a provider" 

extend FriendlyId
 friendly_id :title, use: :slugged

end
