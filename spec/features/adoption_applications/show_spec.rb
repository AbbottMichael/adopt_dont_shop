require 'rails_helper'

RSpec.describe 'Adoption application show page' do
  before :each do
    @adopt_app1 = AdoptionApplication.create(
      name: 'Michael Abbott',
      street_address: '66 Bell St.',
      city: 'Seattle',
      state: 'Wa',
      zip_code: '98121'
    )

    visit "/adoption_applications/#{@adopt_app1.id}"
  end

  it 'shows the adoption application and all its attributes' do
    expect(page).to have_content(@adopt_app1.name)
    expect(page).to have_content(@adopt_app1.street_address)
    expect(page).to have_content(@adopt_app1.city)
    expect(page).to have_content(@adopt_app1.state)
    expect(page).to have_content(@adopt_app1.zip_code)
    expect(page).to have_content('Pets to adopt:')
    expect(page).to have_content(@adopt_app1.description)
    expect(page).to have_content('Status: In Progress')
  end

  it 'can search for pets' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create(name: 'Simba', age: 2, breed: 'Domestic', adoptable: true, shelter_id: shelter.id)
    pet3 = Pet.create(name: 'Baba', age: 4, breed: 'Beagle', adoptable: true, shelter_id: shelter.id)

    fill_in('Search for pets:', with: 'ba')
    click_on("Search")

    expect(current_path).to eq("/adoption_applications/#{@adopt_app1.id}")
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet3.name)
    expect(page).to_not have_content(pet1.name)
  end

  it 'can add a searched pet to the application' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet2 = Pet.create(name: 'Simba', age: 2, breed: 'Domestic', adoptable: true, shelter_id: shelter.id)

    expect(@adopt_app1.pets).to eq([])

    fill_in('Search for pets:', with: 'Simba')
    click_on('Search')
    click_on('Adopt this pet')

    expect(page).to have_content("Pets to adopt: #{pet2.name}")
    expect(@adopt_app1.pets.all).to eq([pet2])
    expect(current_path).to eq("/adoption_applications/#{@adopt_app1.id}")
  end

  describe 'submit an Adoption Application (To Do #21)' do
    # As a visitor
    # When I visit an application's show page
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    # And I click a button to submit this application
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
    before :each do
      @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
      @pet2 = Pet.create(name: 'Simba', age: 2, breed: 'Domestic', adoptable: true, shelter_id: @shelter.id)
    end

    it "displays a section to submit my application after adding 1 or more pets" do
      expect(@adopt_app1.pets.all.count).to eq(0)
      expect(page).to_not have_content('Submit your application')

      fill_in('Search for pets:', with: 'Simba')
      click_on('Search')
      click_on('Adopt this pet')

      expect(@adopt_app1.pets.all.count).to eq(1)
      expect(page).to have_content('Submit your application')
    end

    # it "after submitting application the status is 'Pending'" do
    #   expect(adopt_app1[:status]).to eq('In Progress')
    #
    #   fill_in('Search for pets:', with: 'Simba')
    #   click_on('Search')
    #   click_on('Adopt this pet')
    #   within('#response') do
    #     fill_in('Response:', with: 'I am great!')
    #     click_on('Submit my application')
    #   end
    #
    #   expect(adopt_app1[:status]).to eq('Pending')
    # end
  end
end
