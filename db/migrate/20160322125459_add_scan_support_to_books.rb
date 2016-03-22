class AddScanSupportToBooks < ActiveRecord::Migration
  def change
    add_column :books, :last_click , :datetime
    add_column :books, :last_update, :datetime
    add_column :books, :last_scan  , :datetime
    add_column :books, :scan_tag   , :string
  end
end
