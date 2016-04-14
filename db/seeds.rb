
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
    p @usable_products = @products["Products"]["List"]
    @return_code = @status
    create_wine
  end
end

def create_wine
  @usable_products.each do |child|
    p "#####################################"
    # p @type = child["Type"]
    p @name = child["Name"]
    p @price_min = child["PriceMin"]
    p @price_max = child["PriceMax"]
    p @retail = child["PriceRetail"]
    p @year = child["Year"]
    p @description = child["Description"]
    p @highest_rating = child["Ratings"]["HighestScore"]
    if child["Varietal"]
      @varietal =  child["Varietal"]["Name"]
    end
    if child["Vineyard"]
      p @vineyard = child["Vineyard"]["Name"]
    end
    if child["Appellation"]
      p @region = child["Appellation"]["Region"]["Name"]
    end
  create_wine_object
  end
end

def create_wine_object
  Wine.create(name: @name, price_min: @price_min, price_max: @price_min, retail: @retail, description: @description, highest_rating: @highest_rating, varietal: @varietal, vineyard: @vineyard, region: @region)
end
api_calls

