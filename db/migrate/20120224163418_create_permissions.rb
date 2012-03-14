class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.references :role
      t.string :model_name
      t.string :actions
      t.boolean :situation,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end

