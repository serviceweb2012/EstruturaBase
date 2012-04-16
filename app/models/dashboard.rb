class Dashboard < ActiveRecord::Base
  validates :name, :presence => true
  validates :url, :presence => true
  validates :icon, :presence => true

  def self.list_icons
    icones = []
    Dir.foreach("#{Rails.root.to_s}/public/images/icons") do |arquivo|
      unless arquivo == ".." || arquivo == "."
        icones << arquivo
      end
    end
    icones
  end

end

