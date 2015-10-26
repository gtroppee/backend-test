class Forwarding < ActiveRecord::Base
  belongs_to :phone_number
  belongs_to :call

  delegate :to_s, to: :phone_number
end
