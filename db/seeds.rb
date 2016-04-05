# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'net/http'
require 'json'
def parse_response(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  finished = JSON.parse(response)
  return @status = finished["Status"]["ReturnCode"]
end

def api_calls
  multiple = 100
  return_code = 0
  url = "http://services.wine.com/api/beta2/service.svc/json/catalog?size=#{multiple}&apikey=ad9f081a71cc4ea06097d4c7d4970918"
  while return_code == 0
    parse_response(url)
    multiple += 100
    p return_code = @status
  end
end

api_calls
