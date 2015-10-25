class PhoneNumber < ActiveRecord::Base
  has_many :phone_number_assignments, dependent: :destroy

  has_many :users, through: :phone_number_assignments,
                   source: :callable,
                   source_type: 'User',
                   order: "phone_number_assignments.priority ASC"

  has_many :companies, through: :phone_number_assignments,
                       source: :callable,
                       source_type: 'Company'

  def to_s
    name
  end
end
