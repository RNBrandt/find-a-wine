
require 'net/http'
require 'json'

def parse_response(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  finished = JSON.parse(response)
  @status = finished["Status"]["ReturnCode"]
  @products = finished
end

def api_calls
  multiple = 0
  return_code = 0
  while return_code == 0
    url = "http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&offset=#{multiple}&apikey=ad9f081a71cc4ea06097d4c7d4970918"
    parse_response(url)
    p multiple += 100
    @products
    @products["Products"]["List"][3]["Description"]
    @return_code = @status
  end
end

# def create_wine_object(products)
#   products.each do |product|
#     p product["List"]
#     p "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#   end
# end
api_calls
# create_wine_object(@products)
