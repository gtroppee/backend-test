class Company < ActiveRecord::Base
  include Callable
  has_many :users, dependent: :destroy

  def to_s
    name
  end
end
