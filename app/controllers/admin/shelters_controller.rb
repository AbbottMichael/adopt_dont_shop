class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_name_desc
  end

  # def pets
  #   @shelter = Shelter.find(params[:shelter_id])
  #
  #   if params[:sort] == 'alphabetical'
  #     @shelter_pets = @shelter.alphabetical_pets
  #   elsif params[:age]
  #     @shelter_pets = @shelter.shelter_pets_filtered_by_age(params[:age])
  #   else
  #     @shelter_pets = @shelter.adoptable_pets
  #   end
  # end
end
