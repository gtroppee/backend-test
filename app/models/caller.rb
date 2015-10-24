class Caller
  include Plivo

  def self.dial(params)
    CallLogger.add(params)
    
    recipient_sip = params[:To]
    recipient = User.find_by_sip
    response = Response.new

    if !recipient_sip
      response.addHangup
    else
      response.addSpeak('Thanks for calling acme, you will be routed to voicemail in 15 seconds if he does not answer!')
      dial = response.addDial({ 
        'callerName' => caller_name,
        'action' => 'https://983a260e.ngrok.io/calls/voicemail', 
        'method' => 'POST', 
        'timeout' => '15' 
      })
      dial.addUser(recipient_sip)
    end

    response
  end

  def self.voicemail(params)
    response = Response.new

    if params[:CallStatus] != 'completed'
      response.addSpeak('Please leave a message and press any key when done.')
      response.addRecord({
        'action' => 'https://983a260e.ngrok.io/calls/hangup',
        'method' => 'POST', 
        'maxLength' => '5',
        'playBeep' => 'true'
      }) 
      response.addHangup
    else
      response.addHangup
    end

    response
  end

  def self.forward(params)
    next_in_queue = CallDispatcher.next_sip_endpoint(params)
    
    if next_in_queue
      params = {
        :To         => next_in_queue,
        :From       => params[:From],
        :CallerName => params[:CallerName],
      }
      dial(params)
    else
      voicemail(params)
    end

    response
  end

  def self.hangup(params)
    CallLogger.add(params)
  end
end
