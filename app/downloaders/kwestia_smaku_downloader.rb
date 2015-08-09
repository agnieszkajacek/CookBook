require 'rubygems'
require 'nokogiri'
require 'open-uri'

class KwestiaSmakuDownloader
  def initialize(url)
    page = Nokogiri::HTML(open(url))
    @tytul = page.css('h1.przepis.page-header').text
    @opis = page.css('.group-przepis.field-group-div').text
    @skladniki = []
    @url=url
    
    page.css('div.group-skladniki.field-group-div li').each do |skladnik|
      @skladniki<<skladnik.text
    end
  end
  
  def tytul 
    @tytul
  end
  
  def skladniki
    @skladniki.join(";")
  end
  
  def opis
    @opis
  end
  
  def url
    @url
  end
  
  def zapisz
    Recipe.create(title: tytul, ingredients: skladniki, description: opis, url: url)
  end
end


