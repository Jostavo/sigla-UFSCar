require 'restclient'

response = RestClient.post('localhost:3000/status', :laboratory_id => 21, :lab_tag => "LSO", :isOpen => true)
puts response

