class Location < ActiveRecord::Base
  belongs_to :user
  has_many :pick_ups
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
