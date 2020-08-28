# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Write the code in a way that can be executed multiple times without duplicating the information.
#
# For example:
#
# Country.create(name: "Chile") # BAD
# Country.find_or_create_by(name: "Chile") # GOOD
#

# Users
gabriel = User.find_by(email: 'gabriel@platan.us')
if !gabriel
  User.create!(email: 'gabriel@platan.us', password: 'password')
end
otro_gabriel = User.find_by(email: 'glyon1@uc.cl')
if !otro_gabriel
  User.create!(email: 'glyon1@uc.cl', password: 'password')
end

# Posts
Post.find_or_create_by(user_id: gabriel.id, title: 'Mi primera publicación', content: 'cortita ..')
Post.find_or_create_by(user_id: gabriel.id, title: '¿Qué es Graphql?', content: 'es ...')
Post.find_or_create_by(user_id: gabriel.id, title: '¿Graphql funciona en rails?', content: 'Sí iguals')
