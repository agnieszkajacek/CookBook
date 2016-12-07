require 'rubygems'
require 'nokogiri'
require 'open-uri'

class LidlDownloader
  def initialize(url)
    page       = Nokogiri::HTML(open(url))
    @tytul     = page.css('h1').text
    @opis      = page.css('div.recipe_main .article').inner_html
    @url       = url
    @obrazek   = page.css('div.recipe_main img.watermark')[0]['src']
    @skladniki = page.css('div.skladniki').inner_html
  end

  attr_reader :tytul, :skladniki, :opis, :url, :obrazek

  def przepis
    Recipe.new(title: tytul, ingredients: skladniki, description: opis, url: url, image: obrazek)
  end
end
