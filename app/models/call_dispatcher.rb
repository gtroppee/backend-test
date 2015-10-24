class CallDispatcher

  def initialize(sip_endpoint:)
    @phone_number = PhoneNumber.find_by(sip_endpoint: sip_endpoint)
  end

  def next
    
  end
end