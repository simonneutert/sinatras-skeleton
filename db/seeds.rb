# frozen_string_literal: true

# seed your database
# rake db:seed
Skeleton.create(name: 'Marley')
User.create(username: 'User', password: BCrypt::Password.create('Secret'))
