# Manages the making of the calls
class Caller
  include Plivo

  # Initiates a call to a given number
  def self.dial(params)
    # STEPS
    # 
    # 1 - Get the call information
    # 
    # 2 - Log the call
    # 
    # 3 - Get the list of numbers that can take the call
    # 
    # 4 - Decide if the call is to be forwarded to another number or 
    #     to the voicemail
    # 
    # 5 - Make the call
    # 
    # 6 - Add the current number to the call's forwarding list
    # 
    # 7 - Return the response

    # 1
    response = Response.new

    # 2
    call = CallLogger.log(params)

    # 3
    dispatcher      = CallDispatcher.new(call)
    current_number  = dispatcher.current_number
    next_number     = dispatcher.next_number

    # 4
    action = if next_number
      "#{ENV['HOST']}/calls/dial?To=#{next_number.sip_endpoint}"
    else
      "#{ENV['HOST']}/calls/voicemail"
    end

    # 5
    response.addSpeak("You are trying to reach #{current_number}")
    dial = response.addDial({ 
      callerName: caller_name,
      action: action, 
      method: 'POST',
      timeout: '15'
    })
    dial.addUser(current_number.sip_endpoint)

    # 6
    CallLogger.register_forwarding(call, current_number)

    # 7
    response
  end

  # Redirects the call to the voicemail
  def self.voicemail(params)
    # STEPS
    # 
    # 1 - Get the call information
    # 
    # 2 - Make the call
    # 
    # 3 - Return the response

    # 1
    response = Response.new

    # 2
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

    # 3
    response
  end

  # Well... hangs up
  def self.hangup(params)
    # Log the call information (usually, this is the last update)
    CallLogger.log(params)
  end
end
