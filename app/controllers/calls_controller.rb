class CallsController < ApplicationController
  skip_before_filter :verify_authenticity_token, except: :index

  def index
    @calls = Call.order(id: :desc)
    fresh_when(@calls)
  end

  def dial
    response = Caller.dial(params)
    render xml: response.to_xml
  end

  def voicemail
    response = Caller.voicemail(params)
    render xml: response.to_xml
  end

  def hangup
    Caller.hangup(params)
    render json: {}, status: 200
  end
end