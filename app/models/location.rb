class Location < ActiveRecord::Base
  belongs_to :user
  has_many :pick_ups

  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_validation :lat_changed?

  private

  # This is used to make sure that our address is actually parsed properly and we
  # get a valuable lat/long
  def lat_changed?
    if (self.address_changed?)
      if !(self.latitude_changed?)
        self.errors.add(:address, "is not valid")
        return false
      end
    end
    return true
  end
end
