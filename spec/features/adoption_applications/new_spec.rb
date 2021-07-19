require 'rails_helper'

RSpec.describe 'adoption application creation' do

  describe 'new adoption applicaiton' do
    it 'renders the new form' do
      visit '/adoption_applications/new'

      fill_in('Name', with: 'Michael Abbott')
      fill_in('Street address', with: '66 Bell St.')
      fill_in('City', with: 'Seattle')
      fill_in('State', with: 'Wa')
      fill_in('Zip code', with: '98121')
      click_button('Submit')

      new_app_id = AdoptionApplication.last.id
      expect(current_path).to eq("/adoption_applications/#{new_app_id}")
    end

    it 'can not submit with empty form fields' do
      visit '/adoption_applications/new'

      click_on 'Submit'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Street address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip code can't be blank")
      expect(page).to have_button('Submit')
      expect(current_path).to eq('/adoption_applications')
    end
  end
end
