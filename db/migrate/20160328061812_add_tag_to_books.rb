class AddTagToBooks < ActiveRecord::Migration
  def change
    add_column :books, :tag, :text
  end
end
