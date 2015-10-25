class CompaniesController < ApplicationController

  def index
    @username = "Caller151023165146"
    @password = "materia"

    @company_phone_numbers = PhoneNumber.joins(:phone_number_assignments)
                                        .where(phone_number_assignments: { callable_type: 'Company' })
    @users_phone_numbers = User.all.flat_map(&:personal_number)
  end

end