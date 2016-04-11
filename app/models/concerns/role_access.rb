module RoleAccess
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  def access_validation(current_user)
    return if current_user.nil?
    return if current_user.role_access_level == 0
    return self.errors[:access] << 'You dont have access to do that!' if current_user.role_access_level == 2
    
    if current_user.role_access_level == 1
      access_for_post(current_user)
    end
  end

  def access_for_post(current_user)
    if current_user != self.user
      self.errors[:access] << 'You dont have access to do that!'
    end
  end

  def valid?(context = nil)
    errors.empty?
  end

  def destroy
    if self.valid?
      super
    end
  end
end
