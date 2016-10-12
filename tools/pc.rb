require 'restclient'

response = RestClient.post('localhost:3000/LSO/status', :computer_id=> 1, :status => "available")
puts response

