# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

client_1 = Client.find_or_create_by!(name: 'Foo')

building_1 = Building.find_or_create_by!(address: '123 Main St')
building_1.update!(city: 'Foo', state: 'Foo', zip_code: '11111', client_id: client_1.id)

# ----

client_2 = Client.find_or_create_by!(name: 'Bar')

building_2 = Building.find_or_create_by!(address: '456 Main St')
building_2.update!(city: 'Bar', state: 'Bar', zip_code: '11111', client_id: client_2.id)

# ----

client_3 = Client.find_or_create_by!(name: 'Boston Rentals')

building_3 = Building.find_or_create_by!(address: '123 River Dr')
building_3.update!(city: 'Boston', state: 'MA', zip_code: '11111', client_id: client_3.id)

# ----

client_4 = Client.find_or_create_by!(name: 'NYC Rentals')

building_4 = Building.find_or_create_by!(address: '456 Broadway')
building_4.update!(city: 'New York', state: 'NY', zip_code: '11111', client_id: client_4.id)

# ----

client_5 = Client.find_or_create_by!(name: 'Philadelphia Rentals')

building_5 = Building.find_or_create_by!(address: '789 Philadelphia')
building_5.update!(city: 'Philadelphia', state: 'PA', zip_code: '11111', client_id: client_5.id)