
require 'net/http'
require 'json'

class Snooth
  def initialize(url)
    @url = url
  end

  def parse_response
    uri = URI(url)
    response = Net::HTTP.get(uri)
    finished = JSON.parse(response)
    @products = finished
  end

  def api_call
    multiple = 1
    return_code = 0
    while return_code != 0
      url = "http://api.snooth.com/wines/?akey=#{ENV['SNOOTH_API_KEY']}&ip=#{ENV['IP_ADDRESS']}&q=wine&f=#{multiple}&n=100"
      parse_response(url)
      p multiple += 100
      p @products
      create_wine
    end
  end
end

end

class Wine_com
  def initialize(url)
    @url = url
  end

  def parse_response
  uri = URI(url)
  response = Net::HTTP.get(uri)
  finished = JSON.parse(response)
  @status = finished["Status"]["ReturnCode"]
  @products = finished
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
      create_wine_com
    end
  end
end


def create_wine_object
  wine_var = Wine.new( name: @name, price_min: @price_min, price_max: @price_min, retail: @retail, description: @description, highest_rating: @highest_rating, varietal: @varietal, vineyard: @vineyard, region: @region)
  if wine_var.save
    p wine_var
  end
end

snooth_api_call
