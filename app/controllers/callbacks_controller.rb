class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    return head :ok if params[:secret] != ENV["VK_SECRET"]

    if params['type'] == 'message_new' || params['type'] == 'message_allow'
      message = params['type'] == 'message_new' ? params['object']['message'] : params['object']
      profile = Profile.find_by(uid: params['type'] == 'message_new' ? message['from_id'] : message['user_id']) ||
                Profile.create(uid: params['type'] == 'message_new' ? message['from_id'] : message['user_id'])

      quize = Quiz.first
      service = VkService.new

      if profile.bot_messages.blank? || (params['type'] == 'message_allow' && profile.first_name.blank?)
        question = quize.questions.order(:priority).first
        service.message(profile.uid, question)
      elsif params['type'] == 'message_new'
        last_message = profile.bot_messages.last
        question  = last_message.question

        if question.quiz == quize && (last_message.message_id + 1) == message["id"]
          profile.update(question.special_field => message['text'])
          next_question = quize.questions.where(priority: question.priority + 1).first

          service.message(profile.uid, next_question) if next_question.present?
        end
      end
    elsif params['type'] == 'message_reply'
      message = params['object']
      if message['payload']['type'] == 'bot'
        profile = Profile.find_by(uid: message['peer_id'])
        profile.bot_messages.create!(message_id: message['id'], question_id: message['payload']['question_id'])
      end
    end

    render json: 'ok'
  end
end
