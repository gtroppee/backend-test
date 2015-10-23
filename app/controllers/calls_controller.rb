class CallsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def dial
    response = Caller.dial(params)
    render xml: response.to_xml
  end

  def forward
    
  end

  def hangup
    
  end
end