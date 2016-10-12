require 'restclient'

response = RestClient.post('localhost:3000/status', :laboratory_id => 36, :lab_tag => "LSO", :isOpen => true)
puts response

