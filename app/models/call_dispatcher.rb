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

  private
    def users_tree
      number = PhoneNumber.includes(:phone_number_assignments, phone_number_assignments: :callable)
                          .find_by(sip_endpoint: @call.recipient_sip)
      number.users.where.not(id: forwarded_user_ids)
                  .joins(:phone_number_assignments)
                  .order('phone_number_assignments.priority ASC')
                  .distinct
    end

    def forwarded_user_ids
      @call.user_ids
    end
end