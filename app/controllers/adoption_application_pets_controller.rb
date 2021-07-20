class AdoptionApplicationPetsController < ApplicationController
  def create
    AdoptionApplicationPet.create!(pet_id: "#{params[:pet_id]}", adoption_application_id: "#{params[:adoption_application_id]}")
    redirect_to "/adoption_applications/#{params[:adoption_application_id]}"
  end
end
