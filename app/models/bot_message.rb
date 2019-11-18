class BotMessage < ApplicationRecord
  belongs_to :profile
  belongs_to :question
end
