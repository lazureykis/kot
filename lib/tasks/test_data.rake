require 'open-uri'

namespace :test_data do
  task load: :environment do
    Dungeon.transaction do
      Dungeon.destroy_all

      Dir[Rails.root.join('images/*.jpg')].each do |file|
        Dungeon.create!(description: File.basename(file),
                        image: Pathname.new(file))
      end
    end
  end
end
