class CallDispatcher

  def initialize(call)
    @call = call
  end

  def next_user
    users_tree[1]
  end

  def current_user
    users_tree[0]
  end

  # private
    def users_tree
      number = PhoneNumber.find_by(sip_endpoint: @call.original_recipient_sip)
      number.phone_number_assignments.where.not(id: forwarded_phone_number_assignment_ids)
    end

    def forwarded_phone_number_assignment_ids
      @call.phone_number_assignment_ids
    end
end