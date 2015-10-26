class CallDispatcher

  def initialize(call)
    @call = call
  end

  def next_number
    numbers_tree[1]
  end

  def current_number
    binding.pry
    numbers_tree[0]
  end

  # private
    def numbers_tree
      number = PhoneNumber.find_by(sip_endpoint: @call.original_recipient_sip)
      PhoneNumber.includes(:phone_number_assignments)
                 .where(phone_number_assignments: { callable_id: number.user_ids, callable_type: 'User' } )
                 .where(type: 'UserPhoneNumber')
                 .where.not(id: forwarded_phone_number_ids )
                 .order('phone_number_assignments.priority ASC')
                 .distinct
    end

    def forwarded_phone_number_ids
      @call.phone_number_ids
    end
end