class Call < ActiveRecord::Base
  has_many :forwardings
  has_many :users, through: :forwardings

  def register_forwarding_to(user)
    forwardings.create(user_id: user.id)
  end

  def self.log(params)
    attribs = params.select do |key, val| 
      mapping.has_key?(key) && !val.blank?
    end

    call = find_by(uid: params[:CallUUID]) || new

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
