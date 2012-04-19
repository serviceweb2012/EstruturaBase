class User < ActiveRecord::Base
  belongs_to :role
  validates :role_id, :presence => true
  validates :name, :presence => true,:length => {:minimum => 3}
  validates :username,:presence => true,:length => {:minimum => 3}, :uniqueness => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:lockable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,:username,:role_id,:name

  #
  def self.find_all_with_permission(search, current_user)
    unless search.nil? && search.blank?
      user = User.find(current_user.id)
      if user.role.value == 5
        users = where("username LIKE ?", "%#{search}%").order(:username => :asc)
      else
        users = where("roles.value <> ? AND username LIKE ?", 5, "%#{search}%").order("users.username ASC").joins(:roles)
      end
     else
       if user.role.value == 5
         users = all
      else
        users = where("roles.value <> ?", 5).order("users.username ASC").joins(:roles)
      end
     end
     users
  end

  def updated!
    @updated = true
  end

  def updated?
    @updated
  end

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def recently_activated?
    @activated
  end

  def active?
    activation_code.nil?
  end

  def admin?
    if self.role.value == 5
      true
    else
      false
    end
  end

end

