puts 'Creating user account...'
  user = User.new(
    email: "me_me_me_me@naver.com",
    password: "123456",
    last_name: "Kwon",
    first_name: "Hanbyeol"
  )
  user.save!
puts 'users accounts create'
