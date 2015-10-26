class CompaniesController < ApplicationController
  def index
    @phone_numbers = PhoneNumber.all
    fresh_when(@phone_numbers)
  end
end