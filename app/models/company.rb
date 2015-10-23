class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :phone_numbers, as: :callable,
                           dependent: :destroy

  def to_s
    name
  end
end
