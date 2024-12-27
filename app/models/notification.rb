class Notification < ApplicationRecord
  belongs_to :store
  validates :message, presence: true
end
