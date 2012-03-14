class JoinSubMenusRoles < ActiveRecord::Migration
  def self.up
    create_table :roles_sub_menus,:id => false,:force => true do |t|
      t.integer :sub_menu_id
      t.integer :role_id
    end
  end

  def self.down
    drop_table :roles_sub_menus
  end
end

