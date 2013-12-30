require 'net/http'
require 'net/http/post/multipart'
require 'json'

BASE_URL = "http://127.0.0.1:3000/api/v1"

# Utility methods to GET/POST/PUT/DELETE to the server
def get_from_server(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.request(Net::HTTP::Get.new(uri.request_uri))
  response
end

def send_to_server(url, request, post_data)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  request.body = post_data.to_json
  request["Content-Type"] = "application/json"
  response = http.request(request)
  response
end

def post_to_server(url, post_data)
  request = Net::HTTP::Post.new(URI.parse(url).request_uri)
  send_to_server(url, request, post_data)
end

def put_to_server(url, post_data)
  request = Net::HTTP::Put.new(URI.parse(url).request_uri)
  send_to_server(url, request, post_data)
end

def delete_to_server(url, post_data)
  request = Net::HTTP::Delete.new(URI.parse(url).request_uri)
  send_to_server(url, request, post_data)
end

def response_to_hash(response)
  JSON.parse response.body, symbolize_names: true
end

# Methods to fetch data from the API

def get_endpoints
  response_to_hash(get_from_server(BASE_URL))
end

def get_opportunities
  response_to_hash(get_from_server(BASE_URL + '/opportunities'))
end

def create_opportunity
  url = BASE_URL + '/opportunities/'
  args = {
    title: 'New opportunity',
    summary: 'It\'s really very good',
    company: "Test script Ltd",
    state: 'available'
  }
  response_to_hash(post_to_server(url, args))
end

def update_opportunity(opportunity_id)
  url = BASE_URL + '/opportunities/' + opportunity_id
  args = {
    title: 'Updated!',
    summary: 'Also updated 2!'
  }
  response_to_hash(put_to_server(url, args))
end

def delete_opportunity(opportunity_id)
  url = BASE_URL + '/opportunities/' + opportunity_id
  response_to_hash(delete_to_server(url, {}))
end

def get_applications_for_opportunity(opportunity_id)
  response_to_hash(get_from_server(BASE_URL + '/opportunities/' + opportunity_id + '/applications'))
end

def create_application(opportunity_id, person_id)
  url = BASE_URL + '/opportunities/' + opportunity_id + '/applications'
  args = { 'opportunity_id' => opportunity_id, 'person_id' => person_id }
  response_to_hash(post_to_server(url, args))
end

def update_application(opportunity_id, application_id)
  url = BASE_URL + '/opportunities/' + opportunity_id + '/applications/' + application_id
  args = { 'state' => 'approved' }
  response_to_hash(put_to_server(url, args))
end

def delete_application(opportunity_id, application_id)
  url = BASE_URL + '/opportunities/' + opportunity_id + '/applications/' + application_id
  response_to_hash(delete_to_server(url, {}))
end


# Display the endpoints this API allows
puts "ENDPOINTS ARE:"
get_endpoints[:endpoints].each do |ep|
  puts " * #{ep}"
end
puts "*" * 100

# Get and display the opportunities
opportunities = get_opportunities
puts "OPPORTUNITIES:"
opportunities[:opportunities].each do |opportunity|
  puts " * #{opportunity[:title]} - #{opportunity[:url]}"
end
puts "Next page: #{opportunities[:metadata][:next_page]}"
puts "*" * 100

# Grab the applications for an opportunity we'll pick at random
opportunity = opportunities[:opportunities].sample
applications = get_applications_for_opportunity(opportunity[:id])
puts "APPLICATIONS:"
applications[:applications].each do |application|
  puts " * #{application[:person][:name]} - #{application[:url]}"
end
puts "*" * 100

# Create a new opportunity
created_opportunity = create_opportunity
puts "CREATE OPPORTUNITY RESPONSE:"
puts created_opportunity
puts "*" * 100

# Try and update the opportunity
puts "UPDATE OPPORTUNITY RESPONSE:"
puts update_opportunity(created_opportunity[:id])
puts "*" * 100

puts "DELETE OPPORTUNITY RESPONSE:"
puts delete_opportunity(created_opportunity[:id])
puts "*" * 100

# Now let's try and create an application...
# Grab a person id first
person_id = applications[:applications].first[:person][:id]

new_application = create_application(opportunity[:id], person_id)
puts "CREATE APPLICATION RESPONSE:"
puts new_application
puts "*" * 100

# Now let's try updating our new application
update_application_response = update_application(opportunity[:id], new_application[:id])
puts "UPDATE APPLICATION RESPONSE:"
puts update_application_response
puts "*" * 100

# and then deleting it
deleted_response = delete_application(opportunity[:id], new_application[:id])
puts "DELETE APPLICATION RESPONSE:"
puts deleted_response
puts "*" * 100
