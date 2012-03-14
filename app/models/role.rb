class Role < ActiveRecord::Base
  has_many :permissions
  has_and_belongs_to_many :menus
  has_and_belongs_to_many :sub_menus
  validates_presence_of :name, :value
  validates_uniqueness_of :name
  validates_length_of :name, :within => 3..50
  validates_numericality_of :value, :less_than => 6, :greater_than => -1
  scope :actived?, :conditions => { :situation => true }
end

