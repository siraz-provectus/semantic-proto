class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    return head :ok if params[:secret] != ENV["VK_SECRET"]

    render json: 'ok'
  end
end
