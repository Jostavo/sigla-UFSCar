require 'restclient'

while true do
  RestClient.post('siglaufscar.herokuapp.com/LSO/status', :computer_id=> ARGV[0], :status => "available")
  sleep(540)
end

