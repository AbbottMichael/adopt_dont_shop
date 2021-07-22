require 'rails_helper'

RSpec.describe 'the admin application show page' do
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
    visit "admin/adoption_applications/#{@adopt_app_1.id}"
  end

  describe 'approving a Pet for Adoption' do
    # As a visitor
    # When I visit an admin application show page ('/admin/adoption_applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved
    it 'has a button to approve the adoption of each individual pet' do
      expect(@adopt_app_pet_1.status).to eq(nil)
      expect(@adopt_app_pet_2.status).to eq(nil)

      click_button('Approve Simba')
      @adopt_app_pet_1.reload
      @adopt_app_pet_2.reload

      expect(@adopt_app_pet_1.status).to eq(nil)
      expect(@adopt_app_pet_2.status).to eq('Approved')
    end

    it 'after approval; hides the pets approve button and displays an approved status for the pet' do
      expect(page).to have_button('Approve Mr. Pirate')
      expect(page).to_not have_content('Mr. Pirate Approved')
      expect(page).to have_button('Approve Simba')
      expect(page).to_not have_content('Simba Approved')

      click_button('Approve Simba')

      expect(page).to have_button('Approve Mr. Pirate')
      expect(page).to_not have_content('Mr. Pirate Approved')
      expect(page).to_not have_button('Approve Simba')
      expect(page).to have_content('Simba Approved')
    end
  end

  describe 'rejecting a Pet for Adoption' do
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to reject the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I rejected, I do not see a button to approve or reject this pet
    # And instead I see an indicator next to the pet that they have been rejected
    it 'has a button to reject the adoption of each individual pet' do
      expect(@adopt_app_pet_1.status).to eq(nil)
      expect(@adopt_app_pet_2.status).to eq(nil)

      click_button('Reject Mr. Pirate')
      @adopt_app_pet_1.reload
      @adopt_app_pet_2.reload

      expect(@adopt_app_pet_1.status).to eq('Rejected')
      expect(@adopt_app_pet_2.status).to eq(nil)
    end

    it 'after rejection; hides the pets reject button and displays a rejected status for the pet' do
      expect(page).to have_button('Reject Mr. Pirate')
      expect(page).to_not have_content('Mr. Pirate Rejected')
      expect(page).to have_button('Reject Simba')
      expect(page).to_not have_content('Simba Rejected')

      click_button('Reject Mr. Pirate')

      expect(page).to_not have_button('Reject Mr. Pirate')
      expect(page).to have_content('Mr. Pirate Rejected')
      expect(page).to have_button('Reject Simba')
      expect(page).to_not have_content('Simba Rejected')
    end
  end
end
