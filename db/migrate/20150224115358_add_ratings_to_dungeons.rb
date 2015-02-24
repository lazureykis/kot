class AddRatingsToDungeons < ActiveRecord::Migration
  def change
    add_column :dungeons, :upvotes, :integer, null: false, default: 0
    add_column :dungeons, :downvotes, :integer, null: false, default: 0
  end
end
