class Call < ActiveRecord::Base
  has_many :forwardings
  has_many :phone_numbers, through: :forwardings
end
