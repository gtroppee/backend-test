class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :phone_number_assignments, as: :callable,
                                      dependent: :destroy
  has_many :phone_numbers, through: :phone_number_assignments

  def to_s
    name
  end
end
