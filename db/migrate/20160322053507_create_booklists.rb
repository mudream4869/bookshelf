class CreateBooklists < ActiveRecord::Migration
  def change
    create_table :booklists do |t|
      t.string :title
      t.string :sitename
      t.string :spoturl

      t.timestamps null: false
    end
  end
end
