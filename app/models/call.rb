class Call < ActiveRecord::Base
  has_many :forwardings
  has_many :phone_number_assignments, through: :forwardings

  def register_forwarding_to(phone_number_assignment)
    forwardings.create(phone_number_assignment_id: phone_number_assignment.id)
  end

  def self.log(params)
    attribs = params.select do |key, val| 
      mapping.has_key?(key) && !val.blank?
    end

    call = find_by(uid: params[:CallUUID]) || 
           new(original_recipient_sip: params[:To])

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
        :StartTime => :starts_at,
        :EndTime => :ends_at,
        :AnswerTime => :answered_at,
        :Direction => :direction,
        :Duration => :duration,
        :CallStatus => :status,
        :CallUUID => :uid,
        :TotalCost => :cost,
        :BillRate => :rate,
        :From => :caller_sip,
        :To => :recipient_sip,
        :CallerName => :caller_name,
        :RecordUrl => :record_url,
        :RecordingDuration => :record_length
      })
    end
end
