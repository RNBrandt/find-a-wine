
require 'net/http'
require 'json'

def parse_response(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  finished = JSON.parse(response)
  @status = finished["Status"]["ReturnCode"]
  @products = finished["Products"]
end

def api_calls
  multiple = 0
  return_code = 0
  url = "http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&offset=#{multiple}&apikey=ad9f081a71cc4ea06097d4c7d4970918"
  while return_code == 0
    parse_response(url)
    multiple += 100
    p @products
    p return_code = @status
  end
end

def create_wine_object(product_array)
  product_array.each do |product|
    Wine.new()
  end
end
api_calls
