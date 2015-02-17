class PickUp < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  belongs_to :customer

end
