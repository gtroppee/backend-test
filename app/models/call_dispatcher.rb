class CallDispatcher

  def self.forward(params)
    # Generate a Dial XML to forward an incoming call.

    # The phone number of the person calling your Plivo number,
    # we'll use this as the Caller ID when we forward the call.
    caller_sip_endpoint = params[:From]

    # The number you would like to forward the call to.
    recipient_sip_endpoint = "2222222222"

    # The phone number to be used as the caller id.
    # It can be set to the caller_sip_endpoint or any custom number.
    params = { 'callerId' => caller_sip_endpoint }

    response = Response.new
    dial = response.addDial(params)
    dial.addNumber(recipient_sip_endpoint)

    response
  end
end