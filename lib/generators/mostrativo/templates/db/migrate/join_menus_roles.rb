class JoinMenusRoles < ActiveRecord::Migration
  def self.up
    create_table :menus_roles,:id => false,:force => true do |t|
      t.integer :menu_id
      t.integer :role_id
    end
  end

  def self.down
    drop_table :menus_roles
  end
end

