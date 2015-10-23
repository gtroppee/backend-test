class CompaniesController < ApplicationController

  def index
    @company = Company.includes(:users, :phone_numbers)
                      .first
  end

end