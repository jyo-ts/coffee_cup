class Room < ApplicationRecord
  has_many :messages, dependent: :delete_all
  has_many :entries, dependent: :delete_all
end
