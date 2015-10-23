class PhoneNumber < ActiveRecord::Base
  belongs_to :callable, polymorphic: true, 
                        touch: true

  def to_s
    name
  end
end
