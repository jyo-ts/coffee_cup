class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :messages, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "50x50>" }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
