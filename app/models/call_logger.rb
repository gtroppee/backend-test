# Responsible for the logging logic:
# - creating / updating a given call based on the Plivo response
# - adding forwardings to a given call
class CallLogger < ActiveRecord::Base

  # Adds a forwarding to the call, so we know we have forwarded the call
  # to this number
  def self.register_forwarding(call, phone_number)
    call.forwardings.create(phone_number: phone_number)
  end

  # Logs a call (same for create and update)
  def self.log(params)
    # STEPS
    # 
    # 1 - Selects only the attributes that have a value 
    #     (to prevent the overriding with nil when a key is not present)
    # 
    # 2 - Finds an existing call or build a new one with the original 
    #     recipient number
    # 
    # 3 - Updates the call with the attributes saved before
    # 
    # 4 - Saves and returns the call

    # 1
    attribs = params.select do |key, val| 
      mapping.has_key?(key) && !val.blank?
    end

    # 2
    call = Call.find_by(uid: params[:CallUUID]) || 
           Call.new(original_recipient_sip: params[:To])

    # 3
    attribs.each do |key, val|
      mapped_key = mapping[key]
      call["#{mapped_key}"] = val
    end

    # 4
    call.save
    call
  end

  private

    # Established a unified interface between the Plivo response and our architecture
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
