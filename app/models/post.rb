class Post < ActiveRecord::Base


belongs_to :user, counter_cache: true
paginates_per 6	


acts_as_taggable

validates_presence_of :url
validates :url, :format => URI::regexp(%w(http https))

validates_inclusion_of :provider, :in => ["Mixcloud", "SoundCloud", "Vimeo", "YouTube", "TED"], 
		:message => "not a provider" 

extend FriendlyId
 friendly_id :title, use: :slugged

 has_many :user_favs
 has_many :favourited_by, through: :user_favs, :source => :user

end
