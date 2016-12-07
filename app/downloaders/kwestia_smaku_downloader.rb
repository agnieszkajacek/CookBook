require 'rubygems'
require 'nokogiri'
require 'open-uri'

class KwestiaSmakuDownloader
  def initialize(url)
    page       = Nokogiri::HTML(open(url))
    @tytul     = page.css('h1.przepis.page-header').text
    @opis      = page.css('.group-przepis.field-group-div').inner_html
    @obrazek   = page.css('div.field.field-name-zdjecie-z-linikem-do-bloga.field-type-ds.field-label-hidden img')[0]['src']
    @url       = url

    @skladniki = page.css('div.field.field-name-field-skladniki.field-type-text-long.field-label-hidden').inner_html
  end

  attr_reader :tytul, :skladniki, :opis, :url, :obrazek

  attr_reader :skladniki

  attr_reader :opis

  attr_reader :url

  attr_reader :obrazek

  def przepis
    Recipe.new(title: tytul, ingredients: skladniki, description: opis, url: url, image: obrazek)
  end
end
