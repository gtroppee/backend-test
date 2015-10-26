module Callable
  extend ActiveSupport::Concern
  included do
    has_many :phone_number_assignments, as: :callable, dependent: :destroy
    has_many :phone_numbers, through: :phone_number_assignments
  end
end