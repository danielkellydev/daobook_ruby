class PractitionersController < ApplicationController
  before_action :authenticate_practitioner!

  def show
    @practitioner = current_practitioner
  end

  def edit
    @practitioner = current_practitioner
  end

  def update
    @practitioner = current_practitioner
    if @practitioner.update(practitioner_params)
      redirect_to practitioner_path, notice: 'Practitioner information updated successfully.'
    else
      render :edit
    end
  end

  private

  def practitioner_params
    params.require(:practitioner).permit(:first_name, :last_name, :date_of_birth, :ahpra_number, :phone_number)
  end
end