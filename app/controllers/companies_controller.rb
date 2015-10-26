class CompaniesController < ApplicationController

  def index
    @username = "Caller151023165146"
    @password = "materia"

    @company_phone_numbers = PhoneNumber.includes(:phone_number_assignments)
                                        .where(phone_number_assignments: { callable_type: 'Company' })
    @users_phone_numbers = PhoneNumber.includes(:phone_number_assignments)
                                      .where(phone_number_assignments: { callable_type: 'User' })
  end

end