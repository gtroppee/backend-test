class CallsController < ApplicationController
  include Plivo
  skip_before_filter :verify_authenticity_token, only: [:dial]

  def dial
    to_number = params[:To]
    from_number = params[:CLID] ? params[:CLID] : params[:From] ? params[:From] : ''
    caller_name = params[:CallerName] ? params[:CallerName] : ''

    resp = Response.new

    if not to_number
      resp.addHangup()
    else
      d = resp.addDial({'callerName' => caller_name})
      d.addUser(to_number)
    end

    render xml: resp.to_xml
  end

  def forward
    
  end

  def hangup
    
  end
end