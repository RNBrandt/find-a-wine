
require 'net/http'
require 'json'

def parse_response(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  finished = JSON.parse(response)
  @status = finished["Status"]["ReturnCode"]
  @products = finished
end

def snooth_api_call
  multiple = 0
  return_code = 0
  while return_code == 0
    url = "http://api.snooth.com/wines/?akey=<#{SNOOTH_API_KEY}>&ip=66.28.234.115&q=napa+cabernet&xp=30"
    parse_response(url)
    p multiple += 100
    @usable_products = @products["Products"]["List"]
    @return_code = @status
    create_wine
  end
end
end

def wine_com_api_calls
  multiple = 0
  return_code = 0
  while return_code == 0
    url = "http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&offset=#{multiple}&apikey=#{WINE_COM_API_KEY}"
    parse_response(url)
    p multiple += 100
    @usable_products = @products["Products"]["List"]
    @return_code = @status
    create_wine
  end
end

def create_wine
  @usable_products.each do |child|
    p "#####################################"
    # p @type = child["Type"]
    p @name = child["Name"]["Name"]
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
  wine_var = Wine.new( name: @name, price_min: @price_min, price_max: @price_min, retail: @retail, description: @description, highest_rating: @highest_rating, varietal: @varietal, vineyard: @vineyard, region: @region)
  if wine_var.save
    p wine_var
  end
end
api_calls
# create_wine_object(@products)
