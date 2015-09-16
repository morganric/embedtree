class User < ActiveRecord::Base

  attr_readonly :posts_count

 paginates_per 10


  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  after_create :create_profile

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :user_favs
  has_many :favourites, through: :user_favs, :source => :post

  def create_profile
    @profile = Profile.new(:user_id => id)
    @profile.display_name = self.name
    @profile.save
  end

  def block_from_invitation?
    #If the user has not been confirmed yet, we let the usual controls work
    if confirmed_at.blank?
      return invited_to_sign_up?
    else #if the user was confirmed, we let them in (will decide to accept or decline invitation from the dashboard)
      return false
    end
  end


  # validates_uniqueness_of :name
  # validates_presence_of :name



end
