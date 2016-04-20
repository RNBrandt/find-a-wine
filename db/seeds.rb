
require 'net/http'
require 'json'

class Snooth
  def self.parse_response(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @finished = JSON.parse(response)
    @status = @finished["meta"]["status"]
  end

  def self.wine_overview(url)
    parse_response(url)
    p @wine_overview = @finished["wines"][0]
  end

  def self.descriptions

  def self.api_call
    multiple = 1
    return_code = 1
    while return_code != 0
      @url = "http://api.snooth.com/wines/?akey=#{ENV['SNOOTH_API_KEY']}&ip=#{ENV['IP_ADDRESS']}&q=wine&f=#{multiple}&n=1"
      p wine_overview(@url)
      create_wine_variables
      p multiple += 1
      return_code = @status
    end
  end

  def self.create_wine_variables
    p @type = @wine_overview["type"]
    p @name = @wine_overview["name"]
    p @retail = @wine_overview["price"]
    p @year = @wine_overview["vintage"]
    p @highest_rating = @wine_overview["snoothrank"]
    p  @varietal =  @wine_overview["varietal"]
    p @vineyard = @wine_overview["winery"]
    p @region = @wine_overview["region"]
  end
end

# class Wine_com
#   def initialize(url)
#     @url = url
#   end

#   def parse_response
#   uri = URI(url)
#   response = Net::HTTP.get(uri)
#   finished = JSON.parse(response)
#   @status = finished["Status"]["ReturnCode"]
#   @products = finished
#   end

#   def wine_com_api_calls
#     multiple = 0
#     return_code = 0
#     while return_code == 0
#       url = "http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&offset=#{multiple}&apikey=#{WINE_COM_API_KEY}"
#       parse_response(url)
#       p multiple += 100
#       @usable_products = @products["Products"]["List"]
#       @return_code = @status
#       create_wine_com
#     end
#   end

#   def create_wine
#   @usable_produc @wine_overviewh do |child|
#     p "#####################################"
#     # p @type = child["Type"]
#     p @name = child["Name"]["Name"]
#     p @price_min = child["PriceMin"]
#     p @price_max = child["PriceMax"]
#     p @retail = child["PriceRetail"]
#     p @year = child["Year"]
#     p @description = child["Description"]
#     p @highest_rating = child["Ratings"]["HighestScore"]
#     if child["Varietal"]
#       @varietal =  child["Varietal"]["Name"]
#     end
#     if child["Vineyard"]
#       p @vineyard = child["Vineyard"]["Name"]
#     end
#     if child["Appellation"]
#       p @region = child["Appellation"]["Region"]["Name"]
#     end
#   create_wine_object
#   end
# end
# end



# def create_wine_object
#   wine_var = Wine.new( name: @name, price_min: @price_min, price_max: @price_min, retail: @retail, description: @description, highest_rating: @highest_rating, varietal: @varietal, vineyard: @vineyard, region: @region)
#   if wine_var.save
#     p wine_var
#   end
# end


Snooth.api_call


