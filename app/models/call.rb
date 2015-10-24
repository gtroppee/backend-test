class Call < ActiveRecord::Base

  def self.create_from_plivo(params)
    create(
      starts_at:     params[:StartTime],
      ends_at:       params[:EndTime],
      answered_at:   params[:AnswerTime],
      direction:     params[:Direction],
      duration:      params[:Duration],
      status:        params[:CallStatus],
      uid:           params[:CallUUID],
      cost:          params[:TotalCost],
      rate:          params[:BillRate],
      from_sip:      params[:From],
      to_sip:        params[:To],
      caller_name:   params[:CallerName],
      record_url:    params[:RecordUrl],
      record_length: params[:RecordingDuration]
    )
  end

  def self.update_from_plivo(params)
    call = find_by(uid: params[:CallUUID])
    call.update_attributes(
      starts_at:     params[:StartTime],
      ends_at:       params[:EndTime],
      answered_at:   params[:AnswerTime],
      direction:     params[:Direction],
      duration:      params[:Duration],
      status:        params[:CallStatus],
      uid:           params[:CallUUID],
      cost:          params[:TotalCost],
      rate:          params[:BillRate],
      from_sip:      params[:From],
      to_sip:        params[:To],
      caller_name:   params[:CallerName],
      record_url:    params[:RecordUrl],
      record_length: params[:RecordingDuration]
    )
  end
end
