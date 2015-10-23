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
    
  end

  def self.hangup(params)
    log(params)
    # other things we want to do
  end

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
      from_sip:     params[:From],
      to_sip:       params['SIP-H-To'],
      caller_name:  params[:CallerName]
    )
  end
end