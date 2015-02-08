class Location < ActiveRecord::Base
  belongs_to :user
  has_many :pick_ups
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  validates :name, presence: true
  validates :address, presence: true
end
