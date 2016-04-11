class Note < ActiveRecord::Base
  include RoleAccess

  belongs_to :post
end
