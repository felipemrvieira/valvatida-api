# frozen_string_literal: true

class Admin < ActiveRecord::Base
   # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :trackable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  
  has_many :school_admins, dependent: :nullify
  has_many :schools, through: :school_admins
end
