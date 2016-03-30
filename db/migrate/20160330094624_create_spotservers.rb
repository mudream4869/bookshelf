class CreateSpotservers < ActiveRecord::Migration
  def change
    create_table :spotservers do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
