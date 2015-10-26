class CallLogger < ActiveRecord::Base
  
  def self.register_forwarding(call, phone_number)
    call.forwardings.create(phone_number: phone_number)
  end

  def self.log(params)
    attribs = params.select do |key, val| 
      mapping.has_key?(key) && !val.blank?
    end

    call = Call.find_by(uid: params[:CallUUID]) || 
           Call.new(original_recipient_sip: params[:To])

    attribs.each do |key, val|
      mapped_key = mapping[key]
      call["#{mapped_key}"] = val
    end

    call.save
    call
  end

  private
    def self.mapping
      HashWithIndifferentAccess.new({
        :StartTime         => :starts_at,
        :EndTime           => :ends_at,
        :AnswerTime        => :answered_at,
        :Direction         => :direction,
        :Duration          => :duration,
        :CallStatus        => :status,
        :CallUUID          => :uid,
        :TotalCost         => :cost,
        :BillRate          => :rate,
        :From              => :caller_sip,
        :To                => :recipient_sip,
        :CallerName        => :caller_name,
        :RecordUrl         => :record_url,
        :RecordingDuration => :record_length
      })
    end
end
