class User < ActiveRecord::Base

  validates :name, presence: true, on: :create

  validates :invite_code, inclusion: :in => ["producthunt", "orsii", "mixcloud"], 
    :message => "not a valid code.", on: :create


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

  has_many :posts
  has_one :profile

  def create_profile
    @profile = Profile.new(:user_id => id)
    @profile.display_name = self.name
    @profile.save
  end




end
