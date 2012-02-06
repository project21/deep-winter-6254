class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:username,:address,:address2,:state,:city,:zipcode
  has_many :tokens

  validates_uniqueness_of :username,:message=>"Username already taken"
  validates_presence_of :city, :unless => Proc.new { |m| m.address.blank?  },:message=>"Can not be empty"
  validates_presence_of :state, :unless => Proc.new { |m| m.city.blank?  },:message=>"Can not be empty"
  validates_presence_of :zipcode, :unless => Proc.new { |m| m.state.blank?  },:message=>"Can not be empty"
end
