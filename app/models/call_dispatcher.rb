class CallDispatcher

  def initialize(call)
    @call = call
  end

  def next_number
    numbers_tree[1]
  end

  def current_number
    numbers_tree[0]
  end

  private
    def numbers_tree
      number = PhoneNumber.find_by(sip_endpoint: @call.original_recipient_sip)
      send("numbers_tree_for_#{number.short_type}_number", number)
    end

    def numbers_tree_for_user_number(number)
      [number]
    end

    def numbers_tree_for_company_number(number)
      PhoneNumber.includes(:phone_number_assignments)
                 .where.not(id: forwarded_phone_number_ids )
                 .where(
                    type: 'UserPhoneNumber',
                    phone_number_assignments: { 
                      callable_id: number.user_ids, 
                      callable_type: 'User' 
                    } 
                  )
                 .order('phone_number_assignments.priority ASC')
                 .distinct
    end

    def forwarded_phone_number_ids
      @call.phone_number_ids
    end
end