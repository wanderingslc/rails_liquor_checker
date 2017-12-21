class Location < ApplicationRecord
  require 'set'
  has_many :taggings
  has_many :tags, through: :taggings

  geocoded_by :street_address
  reverse_geocoded_by :latitude, :longitude

  def get_locations(pos)
    # Location.near([pos.lat, pos.lng], 10)
  end

  def get_all_locations
    Location.all
  end

  def get_all_beer
    Location.where(beer: true)
  end

  def street_address
    "#{address['street_address']} #{address['city']} #{address['zip']}"
  end

  scope :within_5, -> (lat, lng) {near([lat, lng], 5)}

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|

      row = Hash[[header, spreadsheet.row(i)].transpose]
      location = Location.find_by(license: row["license"]) || new

      if row["dba"].nil?
        next
      end
      if row['license'].nil?
        next
      end

      row.delete(nil)

      if row['license'].include? "BC"
        location.beer = true
        location.license_type = "Banquet Catering"
      end
      if row['license'].include? 'BE'
        location.beer = true
        location.license_type = "On Premise Beer"
      end

      if row['license'].include? 'CL'
        location.liquor = true
        location.license_type = "Private Club"
      end

      if row['license'].include? 'PS'
        location.beer = true
        location.license_type = 'Public Service Permit'
      end

      if row['license'].include? 'RB'
        location.beer = true
        location.license_type = 'Restaurant - Beer Only'
      end

      if row['license'].include? 'RL'
        location.wine = true
        location.license_type = 'Restaurant - Limited Service'
      end

      if row['license'].include? 'RE'
        location.liquor = true
        location.license_type = 'Restaurant - Full Service'
      end

      if row['license'].include? 'TV'
        location.beer = true
        location.license_type = 'Tavern'
      end

      location.license = row["license"]
      location.name = row["dba"]
      location.address = {
        street_address: row['address'],
        city: row['city'],
        state: row['state'],
        zip: row['zip']
      }
      location.phone = row['phone']
      location.save!
    end

  end
end
