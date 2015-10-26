class Forwarding < ActiveRecord::Base
  belongs_to :phone_number
  belongs_to :call
end
