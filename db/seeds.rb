
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
    @wine_overview = @finished["wines"][0]
  end

  def self.descriptions
    description_url = "http://api.snooth.com/wine/?akey=#{ENV['SNOOTH_API_KEY']}&ip=#{ENV['IP_ADDRESS']}&id=#{@wine_code}&lang=en&n=1"
    parse_response(description_url)
    @description = @finished["wines"][0]["wm_notes"]
  end

  def self.api_call
    multiple = 1
    return_code = 1
    while return_code != 0
      url = "http://api.snooth.com/wines/?akey=#{ENV['SNOOTH_API_KEY']}&ip=#{ENV['IP_ADDRESS']}&q=wine&f=#{multiple}&n=1"
      wine_overview(url)
      p create_wine_variables
      p descriptions
      create_wine_object
      p multiple += 1
      return_code = @status
    end
  end

  def self.create_wine_variables
    p @type = @wine_overview["type"]
    p @wine_code = @wine_overview["code"]
    p @name = @wine_overview["name"]
    p @retail = @wine_overview["price"]
    p @year = @wine_overview["vintage"]
    p @highest_rating = @wine_overview["snoothrank"]
    p @varietal =  @wine_overview["varietal"]
    p @vineyard = @wine_overview["winery"]
    p @region = @wine_overview["region"]
  end

  def self.create_wine_object
    wine_var = Wine.new( name: @name, price_min: @price_min, price_max: @price_min, retail: @retail, description: @description, highest_rating: @highest_rating, varietal: @varietal, vineyard: @vineyard, region: @region)
    if wine_var.save
      p wine_var
    end
  end
end


class Wine_com

  def self.parse_response
  uri = URI(@url)
  response = Net::HTTP.get(uri)
  @products = JSON.parse(response)
  @status = @products["Status"]["ReturnCode"]
  end

  def self.api_call
    multiple = 0
    return_code = 0
    while return_code == 0
      @url = "http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&offset=#{multiple}&apikey=#{ENV['WINE_COM_API_KEY']}"
      parse_response
      p multiple += 100
      @usable_products = @products["Products"]["List"]
      @return_code = @status
      create_wine
    end
  end

  def self.create_wine_object
    wine_var = Wine.new( name: @name, price_min: @price_min, price_max: @price_min, retail: @retail, description: @description, highest_rating: @highest_rating, varietal: @varietal, vineyard: @vineyard, region: @region)
    if wine_var.save
      p wine_var
    end
  end

  def self.create_wine
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
end







Snooth.api_call
Wine_com.api_call

