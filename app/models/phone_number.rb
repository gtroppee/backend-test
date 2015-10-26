class PhoneNumber < ActiveRecord::Base
  has_many :phone_number_assignments, dependent: :destroy

  has_many :users, through: :phone_number_assignments,
                   source: :callable,
                   source_type: 'User'

  has_many :companies, through: :phone_number_assignments,
                       source: :callable,
                       source_type: 'Company'

  has_many :forwardings
  has_many :calls, through: :forwardings

  scope :alphabetic, -> { order(name: :asc) }
  scope :company, -> { where(type: 'CompanyPhoneNumber').alphabetic }
  scope :user, -> { where(type: 'UserPhoneNumber').alphabetic }

  def to_s
    name
  end

  # def short_type
  #   type.partition('PhoneNumber')[0].downcase
  # end
end
