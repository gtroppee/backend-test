class PhoneNumber < ActiveRecord::Base
  has_many :phone_number_assignments, dependent: :destroy

  has_many :users, -> { order 'phone_number_assignments ASC' },
                   through: :phone_number_assignments,
                   source: :callable,
                   source_type: 'User'

  has_many :companies, through: :phone_number_assignments,
                       source: :callable,
                       source_type: 'Company'

  def to_s
    name
  end
end
