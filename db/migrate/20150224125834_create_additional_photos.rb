class CreateAdditionalPhotos < ActiveRecord::Migration
  def change
    create_table :additional_photos do |t|
      t.belongs_to :dungeon, null: false
      t.string :image_uid, null: false
      t.string :image_name, null: true

      t.timestamps null: false
    end
  end
end
