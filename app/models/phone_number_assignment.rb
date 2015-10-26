class PhoneNumberAssignment < ActiveRecord::Base
  belongs_to :phone_number
  belongs_to :callable, polymorphic: true, 
                        touch: true

  before_create :set_priority, if: Proc.new { |a| !a.priority }

  private
    def set_priority
      assignees = PhoneNumberAssignment.where(
        callable_type: 'User', 
        phone_number: phone_number
      )
      self.priority = assignees.count + 1
    end
end
