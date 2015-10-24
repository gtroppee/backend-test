class CallLogger < ActiveRecord::Base

  def self.create_entry(params)
    Call.create_from_plivo(params)
  end

  def self.update_entry(params)
    Call.update_from_plivo(params)
  end
end
