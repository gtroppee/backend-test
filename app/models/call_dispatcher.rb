# Responsible for the dispatching logic:
# - representing the list of numbers to forward the call, for calls
#   that are destined to user numbers or company numbers
class CallDispatcher

  def initialize(call)
    @call = call
  end

  # The number we are currently calling
  def current_number
    numbers_tree[0]
  end

  # The number we will forward to if the current number does not respond
  def next_number
    numbers_tree[1]
  end

  private

    # Redirects to the right method depending on whether we're dealing with
    # a call to a company number or to a user number
    def numbers_tree
      number = PhoneNumber.find_by(sip_endpoint: @call.original_recipient_sip)
      send("numbers_tree_for_#{number.short_type}_number", number)
    end

    # For user numbers we only return the requested number
    def numbers_tree_for_user_number(number)
      [number]
    end

    # For company numbers we return all the numbers that can anwser the
    # requested number, sorted by priority
    def numbers_tree_for_company_number(number)

      # Request detail:
      # 1 - we want the phone numbers of the users that can receive the requested number
      # 2 - we don't want the numbers the call has already been forwarded to
      # 3 - we want it sorted by priority
      PhoneNumber.includes(:phone_number_assignments)
                 .where(
                    type: 'UserPhoneNumber',
                    phone_number_assignments: { 
                      callable_id: number.user_ids, 
                      callable_type: 'User' 
                    } 
                  ) # 1
                 .where.not(id: forwarded_phone_number_ids ) # 2
                 .order('phone_number_assignments.priority ASC') # 3
                 .distinct
    end

    # Returns the ids of the phone numbers the call has already been forwarded to
    def forwarded_phone_number_ids
      @call.phone_number_ids
    end
end