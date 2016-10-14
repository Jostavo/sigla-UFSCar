require 'restclient'

while true do
  RestClient.post('localhost:3000/LSO/status', :computer_id=> 1, :status => "available")
  sleep(540)
end

