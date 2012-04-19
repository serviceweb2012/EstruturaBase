class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.integer :value
      t.boolean :situation,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end

