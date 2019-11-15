class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_admin_user!
  layout 'admin'

  protected
  def after_sign_in_path_for(resource)
    admin_path
  end
end