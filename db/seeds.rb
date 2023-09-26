# USERS
puts "Destroying all users..."
User.destroy_all
puts "Done!"
puts "Creating users..."
User.create!(username: "Cyrielle", email: "cyrielle@gmail.com", password: "123456")
User.create!(username: "Mike", email: "mike@gmail.com", password: "123456")
User.create!(username: "Perrine", email: "perrine@gmail.com", password: "123456")
User.create!(username: "Paul", email: "paul@gmail.com", password: "123456")
puts "4 users are now alive!"

# GROUPS
puts "Destroying all groups..."
Group.destroy_all
puts "Done!"
puts "Creating groups..."
Group.create!(name: "un")
Group.create!(name: "deux")
Group.create!(name: "trois")
Group.create!(name: "quatre")
puts "4 groups are now available!"

# SUBSCRIPTIONS
puts "Creating random subscriptions..."
User.all.each do |user|
  random_number = (1..4).to_a.sample
  groups = Group.all.sample(random_number)
  groups.each { |group| Subscription.create!(user: user, group: group) }
end
puts "All finished!"
