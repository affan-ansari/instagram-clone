# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.new
user.email = 'usama.manzoor@devsinc.com'
user.encrypted_password = '$2a$12$ePQ961uLFdPshrK8ba229ugA.hRkB465we/vRmaFH1tBak5KCuUoO'
user.name = 'Usama Manzoor'
user.save!(validate: false)

user = User.new
user.email = 'muhammad.affan@devsinc.com'
user.encrypted_password = '$2a$12$ePQ961uLFdPshrK8ba229ugA.hRkB465we/vRmaFH1tBak5KCuUoO'
user.name = 'Affan Arif'
user.save!(validate: false)

user = User.new
user.email = 'talha.mustafa@devsinc.com'
user.encrypted_password = '$2a$12$ePQ961uLFdPshrK8ba229ugA.hRkB465we/vRmaFH1tBak5KCuUoO'
user.name = 'Talha Mustafa'
user.save!(validate: false)
