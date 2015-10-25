class PhoneNumberAssignment < ActiveRecord::Base
  belongs_to :phone_number
  belongs_to :callable, polymorphic: true, 
                        touch: true

  before_create :set_priority, if: Proc.new { |a| !a.priority }

  has_many :forwardings
  has_many :calls, through: :forwardings

  private
    def set_priority
      p = PhoneNumberAssignment.where(callable_type: 'User', phone_number: phone_number)
      self.priority = p.count + 1
    end
end
