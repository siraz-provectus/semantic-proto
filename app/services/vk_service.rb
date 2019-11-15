require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class VkService
  def initialize
  end

  def message(user_id, question)
    base_url  = "https://api.vk.com/method/messages.send"
    @uri = URI(base_url)

    https = Net::HTTP.new(@uri.host, @uri.port)
    https.use_ssl = true
    https.read_timeout = 500

    req = Net::HTTP::Post.new(@uri.path)

    random_id = rand(9223372036854775807)

    keyboard = { "one_time": true, "buttons": [
        [{"action": {"type": "text", "label": "Вот так", "payload": {"question": 1, "answer": 1}}, "color": "primary"},
        {"action": {"type": "text", "label": "По другому", "payload": {"question": 1, "answer": 2}}, "color": "primary"}]]}

    toSend = {
      "user_id": "22032578", "random_id": random_id,
      "peer_id": "22032578",
      "message": "Как правильно?",
      "v": "5.101", "access_token": ENV["VK_TOKEN"],
      "keyboard": keyboard.to_json
    }

    req.set_form_data(toSend)
    response = https.request(req)

    error = false
    data = if response.code == '200'
              JSON.parse(response.body)
            else
              error = true
              response.message
           end

    Rails.logger.info '----vk--profile--photos--data---'
    Rails.logger.info data.inspect

    { data: data, error: error }
  end
end