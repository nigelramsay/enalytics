namespace :measurements do
	namespace :heatmiser do 
    desc "Connect to Heatmiser and save current values"
    task :save => :environment do
      SaveHeatmiserValues.new.save
    end
  end
end