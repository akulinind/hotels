class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_many :hotels, :counter_cache => true, dependent: :destroy, :order => "hotels_count DESC"

  has_many :rates, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
    scope :id_desc, ->{
      all.order('id DESC') }
    scope :id_asc, ->{
      all.order('id') }


    scope :name_desc, ->{
      all.order('name DESC') }
    scope :name_asc, ->{
      all.order('name') }
    scope :hotels_desc, ->{
      select('users.*, count(hotels.id) AS hotels_count').
      joins(:hotels).
      group('hotels.user_id').
      order('hotels_count DESC') }
    scope :hotels_asc, ->{
      select('users.*, count(hotels.id) AS hotels_count').
      joins(:hotels).
      group('hotels.user_id').
      order('hotels_count') }
    scope :email_desc, ->{
      all.order('email DESC') }
    scope :email_asc, ->{
      all.order('email') }
    scope :rates_desc, ->{
      select('users.*, count(rates.id) AS rates_count').
      joins(:rates).
      group('rates.user_id').
      order('rates_count DESC') }
    scope :rates_asc, ->{
      select('users.*, count(rates.id) AS rates_count').
      joins(:rates).
      group('rates.user_id').
      order('rates_count') }

  def self.search(search)
    if search
      find(:all, :conditions => ['email LIKE ? or name LIKE?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end