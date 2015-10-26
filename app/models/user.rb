class User < ActiveRecord::Base
  include Callable
  belongs_to :company
  
  def to_s
    name
  end
end
