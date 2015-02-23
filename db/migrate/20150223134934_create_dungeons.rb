class CreateDungeons < ActiveRecord::Migration
  def change
    create_table :dungeons do |t|
      t.string :image_uid, null: false
      t.string :image_name, null: false

      t.integer :level
      t.text :description
      t.string :author_name, null: false
      t.boolean :approved, null: false, default: false

      t.timestamps null: false
    end
  end
end
