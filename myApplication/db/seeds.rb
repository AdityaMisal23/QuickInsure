# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require 'faker'
# -----------------------------------------------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------------------------------------------


# for i in 0..5
#     fake_name = Faker::Name.name
#     User.create(name: fake_name , email: fake_name.split[0].downcase+(i+10).to_s+"@gmail.com", password:  fake_name.split[0].capitalize+"12@"+(i+1).to_s, role: "theater");
# end

# for i in 0..8
#     user = User.find(i+1)
#     user.phone = "8675"+(i).to_s+"4554"+"i+1".to_s
#     user.save
# end

# id | user_id | theater_name | theater_address | pincode |         created_at         |         updated_at         | locations_id 
# more_movies = [
#     "Goodfellas",
#     "The Silence of the Lambs",
#     "Saving Private Ryan",
#     "The Green Mile",
#     "Gladiator",
#     "The Departed",
#     "The Lion King",
#     "Titanic",
#     "Inglourious Basterds",
#     "The Avengers"
# ]
theaters = [
    "Cineplex Odeon",
    "AMC Theatres",
    "Regal Cinemas",
    "Vue Cinemas",
    "Cinemark Theatres",
    "Hoyts Cinemas",
    "Omniplex Cinemas",
    "Ster-Kinekor",
    "PVR Cinemas",
    "Golden Village Cinemas"
]

theater_addresses = [
    "123 Main Street, Anytown, Pune",
    "456 Elm Avenue, Big City, Pune",
    "789 Oak Boulevard, Metropolis, Pune",
    "101 Maple Drive, Smallville, Pune",
    "234 Pine Street, Gotham City, Pune",
    "567 Cedar Lane, Rivertown, Mumbai",
    "890 Birch Road, Lakeside, Mumbai",
    "111 Spruce Avenue, Hilltop, Mumbai",
    "222 Walnut Street, Riverside, Mumbai",
    "333 Cherry Lane, Downtown, Mumbai"
]



# for i in 0..9
#     Movie.create(name: more_movies[i+1])
# end


for i in 22..26
    pincode =  175434
    if  (i - 22) < 4 
        Theater.find_or_create_by(user_id: i, theater_name: theaters[i-22], theater_address: theater_addresses[i-22],  pincode: pincode+i, locations_id: 5);
    else
        Theater.find_or_create_by(user_id: i, theater_name: theaters[i-22], theater_address: theater_addresses[i-22],  pincode: pincode+i, locations_id: 3);
    end
end

# id | name |         created_at         |         updated_at         | theater_id | number_of_seats


# for i in 3..12
#     Screen.create(name: 'A2', theater_id: i, number_of_seats: 30+(i*5));
# end


# id | screen_id | movie_id | show_date  |    show_time    | ticket_price_ordinary | ticket_price_premium | booked_tickets |         created_at         |         updated_at         |     booked_seat 
    
# for i in 18..26
#     Show.create(screen_id: i, movie_id: 9, show_date: Date.current, show_time: Time.current.strftime("%H:%M:%S"), ticket_price_ordinary: 200 + rand(30..70) , ticket_price_premium: 250 + rand(30..100) , booked_tickets: 0, booked_seat: []);
# end


# for i in 4..26
#     show  = Show.find(i);
#     show.booked_seat.push([3,2])
#     show.booked_seat.push([3,3])
#     show.booked_seat.push([3,4])
#     show.booked_tickets = 3
#     show.save;
# end







