class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    return head :ok if params[:secret] != ENV["VK_SECRET"]

    if params['type'] == 'message_new' || params['type'] == 'message_allow'
      message = params['object']['message']
      profile = Profile.find_by(uid: message['from_id']) || Profile.create(uid: message['from_id'])

      quize = Quize.first
      service = VkService.new

      if profile.first_name.blank?
        question = quize.question.first
        service.message(profile.uid, question)
      elsif profile.first_name.blank?
        question = quize.question.first(2).last
        service.message(profile.uid, question)
      elsif profile.age.blank?
        question = quize.question.first(3).last
        service.message(profile.uid, question)
      elsif profile.city.blank?
        question = quize.question.first(4).last
        service.message(profile.uid, question)
      end
    end

    render json: 'ok'
  end
end
