class Admin::TopController < ApplicationController
  before_action :login_admin
  
  def index
  end
end
