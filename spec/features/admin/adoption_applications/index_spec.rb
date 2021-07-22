require 'rails_helper'

RSpec.describe 'the admin adoption application index page' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Simba', breed: 'domestic short hair', age: 12, adoptable: true)
    @adopt_app_1 = AdoptionApplication.create!(
      name: 'Luke Skywalker',
      street_address: 'Bell St.',
      city: 'Seattle',
      state: 'Wa',
      zip_code: '98121',
      status: 'Pending',
      description: 'I am a Jedi.'
    )
    @adopt_app_pet_1 = AdoptionApplicationPet.create!(pet_id: @pet_1.id, adoption_application_id: @adopt_app_1.id)
    @adopt_app_pet_2 = AdoptionApplicationPet.create!(pet_id: @pet_2.id, adoption_application_id: @adopt_app_1.id)
    visit "/admin/adoption_applications"
  end

  it 'displays all of the adoption applications' do
    expect(page).to have_content("#{@adopt_app_1.name}'s Application")
  end
end
