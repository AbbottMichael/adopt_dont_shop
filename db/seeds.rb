# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdoptionApplicationPet.destroy_all
Pet.destroy_all
AdoptionApplication.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_2.pets.create(name: 'Abby', breed: 'west highland white terrier', age: 4, adoptable: true)
pet_4 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_5 = shelter_3.pets.create(name: 'Simba', breed: 'domestic short hair', age: 12, adoptable: true)
pet_6 = shelter_3.pets.create(name: 'Molly', breed: 'golden retriever', age: 8, adoptable: true)

adopt_app_1 = AdoptionApplication.create(
  name: 'Luke Skywalker',
  street_address: 'Bell St.',
  city: 'Seattle',
  state: 'Wa',
  zip_code: '98121',
  status: 'Pending',
  description: 'I am a Jedi.'
)

adopt_app_2 = AdoptionApplication.create(
  name: 'Darth Vader',
  street_address: 'lava lane',
  city: 'Mustafar',
  state: 'Wa',
  zip_code: '98666',
  status: 'Pending',
  description: 'Bad idea.'
)
adopt_app_3 = AdoptionApplication.create(
  name: 'Han Solo',
  street_address: 'Millennium Dr.',
  city: 'Somewhere',
  state: 'Corellian',
  zip_code: '97324',
  status: 'Pending',
  description: 'Chewy needs a friend.'
)

adopt_app_4 = AdoptionApplication.create(
  name: 'Leia Organa',
  street_address: 'lava lane',
  city: 'Someplace',
  state: 'Alderaan',
  zip_code: '98133',
  status: 'Pending',
  description: 'I lost all of my other friends.'
)

AdoptionApplicationPet.create(pet_id: pet_1.id, adoption_application_id: adopt_app_1.id)
AdoptionApplicationPet.create(pet_id: pet_2.id, adoption_application_id: adopt_app_1.id, status: 'Approved')
AdoptionApplicationPet.create(pet_id: pet_1.id, adoption_application_id: adopt_app_2.id)
AdoptionApplicationPet.create(pet_id: pet_2.id, adoption_application_id: adopt_app_2.id)
AdoptionApplicationPet.create(pet_id: pet_6.id, adoption_application_id: adopt_app_3.id)
AdoptionApplicationPet.create(pet_id: pet_5.id, adoption_application_id: adopt_app_3.id)
AdoptionApplicationPet.create(pet_id: pet_5.id, adoption_application_id: adopt_app_4.id)
AdoptionApplicationPet.create(pet_id: pet_6.id, adoption_application_id: adopt_app_4.id)
