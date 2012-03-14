class Menu < ActiveRecord::Base
  has_many :sub_menus, :order => "position ASC", :dependent => :destroy
  has_and_belongs_to_many :roles
  validates_presence_of :name
  validates_length_of :name, :within => 3..100
  validates_uniqueness_of :name
  scope :actived?, :conditions => { :situation => true }
end

