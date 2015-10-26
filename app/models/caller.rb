class Caller
  include Plivo

  def self.dial(params)
    recipient_sip = params[:To]
    caller_name   = params[:CallerName]
    response      = Response.new

    call = Call.log(params)
    dispatcher = CallDispatcher.new(call)

    current_number = dispatcher.current_number
    next_number = dispatcher.next_number
    action = if next_number
      "#{ENV['HOST']}/calls/dial?To=#{next_number.sip_endpoint}"
    else
      "#{ENV['HOST']}/calls/voicemail"
    end

    if !recipient_sip
      response.addHangup
    else
      response.addSpeak("You are trying to reach #{current_number}")
      dial = response.addDial({ 
        callerName: caller_name,
        action: action, 
        method: 'POST',
        timeout: '15'
      })
      dial.addUser(current_number.sip_endpoint)
    end

    call.register_forwarding_to(current_number)
    response
  end

  def self.voicemail(params)
    response = Response.new

    if params[:CallStatus] != 'completed'
      response.addSpeak('No one could answer the phone. Please leave a message after the beep.')
      response.addRecord({
        action: "#{ENV['HOST']}/calls/hangup",
        method: 'POST', 
        maxLength: '5',
        playBeep: 'true'
      })
      response.addHangup
    else
      response.addHangup
    end
    response
  end

  def self.hangup(params)
    Call.log(params)
  end
end
