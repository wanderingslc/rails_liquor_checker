namespace :geo_location do
  desc "Check each location for lat long, retrive if missing"
  task :geolocate => :environment do
    Location.find_in_batches(batch_size: 100) do |loc|
      loc.each do |l|
        if l.longitude == nil
          sleep 0.5
          l.geocode
          l.save
        end
      end
    end
  end

end