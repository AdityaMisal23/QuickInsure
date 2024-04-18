Rails.application.routes.draw do
  get "log/index"
  get "payment/index"
  get "booking/index"
  get "user", to: "user#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "user/login", to: "user#login"

  post "user/signup", to: "user#signup"

  get "movie/movies", to: "movie#get_all_movies"

  get "theater/theaters", to: "theater#get_all_theaters_based_on_location"

  get "user/namedMovie", to: "user#get_movie_by_name"

  get "show/getAllBookedSeats", to: "show#get_all_booked_seat"

  get "location/getAllCities", to: "location#index"

  get "user/getNames", to: "user#user_names"

  get "movie/serachMovie", to: "movie#serach_a_movie"

  post "show/updateTicket", to: "show#update_show_ticket_price"

  get "movie/topMovies", to: "movie#get_top_todays_movies"

  get "booking/bookTicket", to: "booking#book_a_ticket"

  get "show/getBookings", to: "show#get_all_bookings"

  get "show/getAvailability", to: "show#get_seat_availability"

  get "payment/getPaymentDeatils", to: "payment#get_payment_details"

  get "log/getUserLogs", to: "log#get_logs_of_user"

  get "movie/getMoviesUsingGenre", to: "movie#find_movie_using_genre"

  resources :show

  resources :user

  resources :theater

  resources :movie

  resources :booking

  resources :screen

  resources :location

  resources :payment

  resources :log
end

#   get '/user_controller', to: 'user_controller#index'
# end
