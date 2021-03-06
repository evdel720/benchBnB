class Bench < ActiveRecord::Base
  validates :description, :lat, :lng, presence: true

  def self.in_bounds(bounds)
    Bench.where("lat < ?", bounds[:northEast][:lat])
         .where("lat > ?", bounds[:southWest][:lat])
         .where("lng < ?", bounds[:northEast][:lng])
         .where("lng > ?", bounds[:southWest][:lng])
  end
end
