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

  get "theater/getTheaterOnLcationAndMovie", to: "theater#get_theater_on_location_and_movie"

  get "user/namedMovie", to: "user#get_movie_by_name"

  get "show/getAllBookedSeats", to: "show#get_all_booked_seat"

  get "user/getNames", to: "user#user_names"

  get "movie/serachMovie", to: "movie#serach_a_movie"

  post "show/updateTicket", to: "show#update_show_ticket_price"

  get "movie/topMovies", to: "movie#get_top_todays_movies"

  get "booking/bookTicket", to: "booking#book_a_ticket"

  get "show/getBookings", to: "show#get_all_bookings"

  get "screen/getTheaterScreensOfMovie", to: "screen#get_theater_screens_of_movie"

  get "screen/getTheaterScreens", to: "screen#get_theater_screens"

  get "show/getAvailability", to: "show#get_seat_availability"

  get "payment/getPaymentDeatils", to: "payment#get_payment_details"

  get "log/getUserLogs", to: "log#get_logs_of_user"

  get "movie/getMoviesUsingGenre", to: "movie#find_movie_using_genre"

  get "movie/searchMovie", to: "movie#search_a_movie"

  get "theater/getUserTheaters", to: "theater#get_user_theaters"

  get "booking/getBookings", to: "booking#get_bookings"

  get "screen/isPremium", to: "screen#is_premium"

  get "movie/getLatestMovie", to: "movie#get_latest_movies"

  get "show/showSeatPrice", to: "show#show_seat_price"

  get "show/getShowsOfMovie", to: "show#get_shows_of_movie"

  get "show/checkSlotAvailable", to: "show#check_slot_available"

  get "show/getShowsOfsreenAndDate", to: "show#get_shows_of_sreen_And_Date"

  get "user/getUsersBasedOnRole", to: "user#get_users_based_on_role"

  get "/login", to: "static_pages#login"

  get "/signup", to: "static_pages#signup"

  get "/home", to: "static_pages#home_page"

  get "movie/get_url" , to: "movie#get_url"

  post "movie/update_movie_poster" , to: "movie#update_movie_poster"

  resources :show

  resources :user

  resources :theater

  resources :movie

  resources :booking

  resources :screen

  resources :location

  resources :payment

  resources :log

  root "movie#get_latest_movies"
end

#   get '/user_controller', to: 'user_controller#index'
# end
