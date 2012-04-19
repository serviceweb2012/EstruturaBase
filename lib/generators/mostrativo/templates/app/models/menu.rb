class Menu < ActiveRecord::Base
  has_many :sub_menus, :order => "position ASC", :dependent => :destroy
  has_and_belongs_to_many :roles
  validates_presence_of :name
  validates_length_of :name, :minimum => 4
  validates_uniqueness_of :name
  scope :actived?, :conditions => { :situation => true }

  def self.menus_by_permission(current_user)
    if current_user.role.id == 1
      order('position ASC')
    else
      select('menus.*').joins(:roles).where('roles.id = ?',current_user.role.id).order("menus.position ASC")
    end
  end
end

