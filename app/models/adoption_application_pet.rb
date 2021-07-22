class AdoptionApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_application

  def pet_record
    Pet.find_by(id: self.pet_id)
  end
end
