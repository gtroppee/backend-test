class Call < ActiveRecord::Base
  has_many :forwardings, dependent: :destroy
  has_many :phone_numbers, through: :forwardings
end
