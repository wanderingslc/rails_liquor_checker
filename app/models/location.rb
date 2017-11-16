class Location < ApplicationRecord
  require 'set'
  has_many :taggings
  has_many :tags, through: :taggings

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|

      row = Hash[[header, spreadsheet.row(i)].transpose]
      location = Location.find_by(license: row["license"]) || new

      if row["dba"].nil?
        next
      end

      row.delete(nil)
      types = []
      types << "3.2" if row["license"].include? "BE"
      types << "Wine" if row["license"].include? "RL"
      if row["license"].include? "RE"
        types << "3.2"
        types << "Wine"
        types << "Liquor"
      end
      if row["license"].include? "CL"
        types << "3.2"
        types << "Wine"
        types << "Liquor"
      end
      location.liquor = types.uniq
      location.license = row["license"]
      location.name = row["dba"]
      location.address = row["address"]
      location.city = row['city']
      location.state = row['state']
      location.zip = row['zip']
      location.phone = row['phone']
      location.save!
    end

  end
end
