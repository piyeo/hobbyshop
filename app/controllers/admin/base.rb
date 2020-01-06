class Admin::Base < ApplicationController
  before_action :admin_login_user

  def admin_login_user
    raise Forbidden unless current_admin
  end
  
end
