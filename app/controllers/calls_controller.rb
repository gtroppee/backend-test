class CallsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def dial
    response = Caller.dial(params)
    render xml: response.to_xml
  end

  def voicemail
    response = Caller.voicemail(params)
    render xml: response.to_xml
  end

  def hangup
    response = Caller.hangup(params)
    render xml: response.to_xml
  end
end