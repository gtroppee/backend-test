class PhoneNumber < ActiveRecord::Base
  belongs_to :callable, polymorphic: true, 
                        touch: true
end
