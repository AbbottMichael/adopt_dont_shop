class AdoptionApplicationPetsController < ApplicationController
  def create
    AdoptionApplicationPet.create!(adopt_app_pet_params)
    redirect_to "/adoption_applications/#{params[:adoption_application_id]}"
  end

  private

  def adopt_app_pet_params
    params.permit(:pet_id, :adoption_application_id)
  end
end
