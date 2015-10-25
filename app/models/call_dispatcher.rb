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
      number.users.where.not(id: forwarded_user_ids)
    end

    def forwarded_user_ids
      @call.user_ids
    end
end