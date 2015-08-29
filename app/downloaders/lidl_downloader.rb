require 'rubygems'
require 'nokogiri'
require 'open-uri'

class LidlDownloader
  def initialize(url)
    page       = Nokogiri::HTML(open(url))
    @tytul     = page.css('h1').text
    @opis      = page.css('div.recipe_steps').inner_html
    @url       = url
    @obrazek   = page.css('div.image img')[0]['src']
    @skladniki = page.css('div.recipe_products').inner_html
  end

  def tytul
    @tytul
  end

  def skladniki
    @skladniki
  end

  def opis
    @opis
    end

  def url
    @url
  end

  def obrazek
    @obrazek
  end

  def przepis
    Recipe.new(title: tytul, ingredients: skladniki, description: opis, url: url, image: obrazek)
  end
end
