class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  
  has_secure_password
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :email, :uniqueness => true 
  validates :login, :uniqueness => true 
  validates :password, :presence => true, :on => :create
  
  scope :active, where('active > 0')
  
  def admin?
    true if self.roles[/9/] == "9" 
  end

  def active?
    true if self.active > 0
  end

end
