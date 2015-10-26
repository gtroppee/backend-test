class User < ActiveRecord::Base
  include Callable
  belongs_to :company
  
  def to_s
    name
  end

  def personal_number
    phone_numbers.find_by(name: name)
  end

  def personal_sip
    personal_number.sip_endpoint
  end
end
