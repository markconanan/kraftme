class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  has_many :products, dependent: :destroy
  
  has_and_belongs_to_many :roles, :join_table => :users_roles
  
  validates :username, allow_blank: true, allow_nil: true, length: {maximum: 50}, uniqueness: {message: ->(object, data) do
     "#{data[:value]} is taken already!" 
    end }
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :address, presence: true, length: {maximum: 100}
  validates :city, presence: true, length: {maximum: 50}
  validates :postcode, presence: true, numericality: { only_interger: true}, length: {is: 4}
  validates :state, presence: true, length: {in: 2..3},format: { with: /\A[A-Z]+\z/, message: "Only allows capital letters"}
  
  
  
  
  # sets default role of 'standard_user' upon creation of user class 
  after_create :set_default_role
  
  def set_default_role
    self.add_role(:standard_user) if self.roles.blank?
  end
  
end
