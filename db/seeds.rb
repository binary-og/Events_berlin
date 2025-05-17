# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Clear old data
User.destroy_all
Event.destroy_all
Invite.destroy_all
Attending.destroy_all

# Create users
alice = User.create!(email: "alice@example.com", password: "password")
bob = User.create!(email: "bob@example.com", password: "password")
carol = User.create!(email: "carol@example.com", password: "password")

# Public event
public_event = alice.created_events.create!(
  name: "Public Berlin Tech Meetup",
  description: "Open to everyone",
  location: "Berlin HQ",
  date: 1.week.from_now,
  private: false
)

# Private event
private_event = bob.created_events.create!(
  name: "Private Founders Roundtable",
  description: "Invite-only gathering",
  location: "Secret Loft",
  date: 1.week.from_now,
  private: true
)

# Attending
public_event.attendees << carol
public_event.attendees << bob

# Invite Carol to private event
Invite.create!(event: private_event, inviter: bob, invitee: carol)

puts "Seeded: Users + Events + Invites + Attendings"
puts "Created #{User.count} users"
puts "Created #{Event.count} events"
puts "Created #{Invite.count} invites"
puts "Created #{Attending.count} attendings"
puts "Created #{public_event.attendees.count} attendees for public event"
puts "Created #{private_event.invitees.count} invitees for private event"
