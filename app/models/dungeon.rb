class Dungeon < ActiveRecord::Base
  dragonfly_accessor :image

  def title
    [level || id, author_name.presence].compact.join(' : ')
  end
end
