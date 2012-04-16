class SubMenu < ActiveRecord::Base
  belongs_to :menu
  has_and_belongs_to_many :roles
  validates_presence_of :menu_id, :name, :url, :title
  validates_length_of :name, :within => 3..100
  validates_uniqueness_of :name,:url
  scope :actived?, :conditions => { :situation => true }


  def self.list_sub_menu_by_permission(current_user)
    if current_user.role.id == 1
      order('name ASC')
    else
      select('sub_menus.name,sub_menus.url').joins(:roles).where('roles.id = ?',current_user.role.id)
    end
  end
end

