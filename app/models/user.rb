class User < ActiveRecord::Base
  belongs_to :company
  has_many :phone_number_assignments, as: :callable,
                                      dependent: :destroy
  has_many :phone_numbers, through: :phone_number_assignments
  
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
