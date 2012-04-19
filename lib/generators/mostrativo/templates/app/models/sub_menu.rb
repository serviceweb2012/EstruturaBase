class SubMenu < ActiveRecord::Base
  belongs_to :menu
  has_and_belongs_to_many :roles
  validates_presence_of :menu_id, :name, :url, :title
  validates_length_of :name, :within => 3..100
  validates_uniqueness_of :name,:url
  scope :actived?, :conditions => { :situation => true }


  def self.list_sub_menu_by_permission(current_user)
    if current_user.role.id == 1
      order('position ASC')
    else
      select('sub_menus.name,sub_menus.url').joins(:roles).where('roles.id = ?',current_user.role.id).order('sub_menus.position ASC')
    end
  end

  def self.list_sub_menu_by_menu_and_permission(menu_id,current_user)
    if current_user.role.id == 1
      where('menu_id = ?',menu_id).order('position ASC')
    else
      joins(:roles).where('sub_menus.menu_id = ? AND roles.id = ?',menu_id,current_user.role.id).order('position ASC')
    end
  end

end

