class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :adoption_application_pets
  has_many :adoption_applications, through: :adoption_application_pets

  validates :name, presence: true
  validates :age, presence: true, numericality: true

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  # def self.
  #   average("age")
  # end
end
