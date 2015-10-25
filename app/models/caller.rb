class Caller
  include Plivo

  def self.dial(params)
    recipient_sip = params[:To]
    caller_name   = params[:CallerName]
    response      = Response.new

    call = Call.log(params)
    dispatcher = CallDispatcher.new(call)

    current_user = dispatcher.current_user
    next_user = dispatcher.next_user

    if !recipient_sip
      response.addHangup
    elsif next_user
      response.addSpeak("You are trying to reach #{current_user}")
      dial = response.addDial({ 
        callerName: caller_name,
        action: "https://983a260e.ngrok.io/calls/dial?To=#{next_user.personal_sip}", 
        method: 'POST',
        timeout: '15'
      })
      dial.addUser(recipient_sip)
    else
      response.addSpeak("You are trying to reach #{current_user}")
      dial = response.addDial({ 
        callerName: caller_name,
        action: 'https://983a260e.ngrok.io/calls/voicemail', 
        method: 'POST', 
        timeout: '15' 
      })
      dial.addUser(recipient_sip)
    end

    call.register_forwarding_to(current_user)
    response
  end

  def self.voicemail(params)
    response = Response.new

    if params[:CallStatus] != 'completed'
      response.addSpeak('No one could answer the phone. Please leave a message and press any key when done.')
      response.addRecord({
        action: 'https://983a260e.ngrok.io/calls/hangup',
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
