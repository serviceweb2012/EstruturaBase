class CreateReportErrors < ActiveRecord::Migration
  def self.up
    create_table :report_errors do |t|
      t.references :user
      t.string :name
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :report_errors
  end
end
