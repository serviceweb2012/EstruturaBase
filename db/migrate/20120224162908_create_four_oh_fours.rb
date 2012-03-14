class CreateFourOhFours < ActiveRecord::Migration
  def self.up
    create_table :four_oh_fours do |t|
      t.string :host,:limit => 100
      t.string :path
      t.string :referer
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :four_oh_fours
  end
end

