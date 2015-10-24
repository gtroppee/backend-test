class Caller
  include Plivo

  def self.dial(params)
    to_number = params[:To]
    from_number = params[:CLID] ? params[:CLID] : params[:From] ? params[:From] : ''
    caller_name = params[:CallerName] ? params[:CallerName] : ''

    resp = Response.new

    if !to_number
      resp.addHangup()
    else
      d = resp.addDial({'callerName' => caller_name})
      d.addUser(to_number)
    end

    resp
  end

  def self.forward(params)
    # Generate a Dial XML to forward an incoming call.

    # The phone number of the person calling your Plivo number,
    # we'll use this as the Caller ID when we forward the call.
    from_number = params[:From]

    # The number you would like to forward the call to.
    forwarding_number = "2222222222"

    # The phone number to be used as the caller id.
    # It can be set to the from_number or any custom number.
    params = { 'callerId' => from_number }

    response = Response.new()
    dial = response.addDial(params)
    dial.addNumber(forwarding_number)

    response
  end

  def self.hangup(params)
    if params[:Duration].to_i.zero?
      forward(params)
    else
      log(params)
    end
  end

  def self.voicemail(params)
    if params[:Duration].to_i.zero?
      forward(params)
    else
      log(params)
    end
  end

  private
    def self.log(params)
      create(
        starts_at:    params[:StartTime],
        ends_at:      params[:EndTime],
        answered_at:  params[:AnswerTime],
        direction:    params[:Direction],
        duration:     params[:Duration],
        status:       params[:CallStatus],
        uid:          params[:CallUUID],
        cost:         params[:TotalCost],
        rate:         params[:BillRate],
        from_sip:     params[:From],
        to_sip:       params['SIP-H-To'],
        caller_name:  params[:CallerName]
      )
  end
end