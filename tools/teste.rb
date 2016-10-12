require 'restclient'

response = RestClient.post('localhost:8080/enroll')
puts response

