class User < ActiveRecord::Base
  belongs_to :company
  has_many :phone_numbers, as: :callable,
                           dependent: :destroy
  
  def to_s
    name
  end
end
