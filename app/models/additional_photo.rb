class AdditionalPhoto < ActiveRecord::Base
  dragonfly_accessor :image

  belongs_to :dungeon
end
