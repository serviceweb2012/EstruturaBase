class SubMenu < ActiveRecord::Base
  belongs_to :menu
  has_and_belongs_to_many :roles
  validates_presence_of :menu_id, :name, :url, :title
  validates_length_of :name, :within => 3..100
  validates_uniqueness_of :name,:url
  scope :actived?, :conditions => { :situation => true }
end

