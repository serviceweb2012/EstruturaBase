class CreateSubMenus < ActiveRecord::Migration
  def self.up
    create_table :sub_menus do |t|
      t.references :menu
      t.string :name
      t.string :title
      t.string :url
      t.integer :position
      t.boolean :separator
      t.boolean :adm
      t.boolean :situation

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_menus
  end
end
