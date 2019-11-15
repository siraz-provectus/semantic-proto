class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    return head :ok if params[:secret] != ENV["VK_SECRET"]

    if params['type'] == 'message_new' || params['type'] == 'message_allow'
      message = params['object']['message']
      profile = Profile.find_by(uid: message['from_id']) || Profile.create(uid: message['from_id'])
    end

    render json: 'ok'
  end
end
