require "nokogiri"
require "httparty"
require "open-uri"

module Wikipedia
  class Page
    include HTTParty
    default_params :action => 'opensearch', :format => 'json'
  
    ##
    # Uses the Wikipedia API to perform a search
    #
    # @param [String] a search term
    # @return [Array] the results of the search
    def search(term)
      raise ArgumentError, 'You must search for something' if term.blank?
      self.class.get('http://en.wikipedia.org/w/api.php',:query => {:search => term})[1]
    end
  
    ##
    # Scape a wikipedia page and return the first two paragraphs
    #
    # @param [String] page the page to be scraped
    # @return [String, String] the first two paragraphs
    def scrape(page)
      doc = self.fetch_doc(page)
      # Search for <p> tags by xpath
      paragraphs = []
      doc.xpath('//p').each_with_index do |a_tag, i|
        paragraphs << a_tag.content
      end
      # take paragraphs and remove refrences ([n]) and \" characters
      first_paragraph = paragraphs[0].gsub(/[\\"]|\[\d*\]/,'')
      second_paragraph =  paragraphs[1].gsub(/[\\"]|\[\d*\]/,'')
    
      return first_paragraph, second_paragraph
    end
    
    ##
    # Builds the wikipedia page URL and the HTML document
    #
    # @param [String] page the page we want to fetch
    # @return [Nokogiri::HTML::Document] the HTML of the page
    def fetch_doc(page)
      url = "http://en.wikipedia.org/wiki/#{URI.escape page}"
      Nokogiri::HTML(open(url))
    end
  end
end
