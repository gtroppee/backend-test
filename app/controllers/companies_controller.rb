class CompaniesController < ApplicationController

  def index
    @username = "Caller151023165146"
    @password = "materia"

    @company_phone_numbers = PhoneNumber.where(callable_type: 'Company')
    @users_phone_numbers = PhoneNumber.where(callable_type: 'User')
  end

end