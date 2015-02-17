class PickUp < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  belongs_to :customer

  validates :customer_id, presence: true
  validates :location_id, presence: true
  validates :item, presence: true
  validates :quantity, presence: true

end
