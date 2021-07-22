class Admin::AdoptionApplicationsController < ApplicationController

  def show
    @adopt_app =         AdoptionApplication.find(params[:id])
    @app_pets_approved = AdoptionApplicationPet.where(adoption_application_id: params[:id], status: 'Approved')
    @app_pets_rejected = AdoptionApplicationPet.where(adoption_application_id: params[:id], status: 'Rejected')
    @app_pets_pending =  AdoptionApplicationPet.where(adoption_application_id: params[:id], status: nil)
  end

  def update
    @app_pet = AdoptionApplicationPet.where({ adoption_application_id: params[:id], pet_id: params[:pet_id] })
    @app_pet.update(status: params[:status])
    redirect_to "/admin/adoption_applications/#{params[:id]}"
  end
end
