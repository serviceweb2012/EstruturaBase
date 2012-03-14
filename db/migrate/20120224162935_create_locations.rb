class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :state
      t.string :uf
      t.string :url_site
      t.string :cep
      t.string :phone
      t.string :email
      t.string :url_map
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end

