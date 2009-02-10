require "nokogiri"
require "httparty"
require "open-uri"

module Wikipedia
  class Page
    include HTTParty
    default_params :action => 'opensearch', :format => 'json'
  
    attr_accessor :document
  
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
      self.fetch_doc(page)
      # Search for <p> tags by xpath
      paragraphs = []
      @document.xpath('//p').each_with_index do |a_tag, i|
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
      @document ||= Nokogiri::HTML(open(url))
    end
    
    ##
    # Nice idea but doesn't work in many cases.
    # Return the first external link in the infobox (most likely to be the main webpage)
    #
    # @param [String] page the page we want to fetch
    # @return [String] a link to scrape for images
    # def find_first_link(page)
    #   self.fetch_doc(page)
    #   first_link = @document.xpath("//td/a[contains(@class,'external')]").map{|n|n.attributes["href"].content}[0]
    #   base, _x = first_link.match(/(http:\/\/.*)(\/.*\/)/).captures
    #   base
    # end
  end
  # image scraping just doesn't work, will have to be manual
  # class Images
  #     
  #     attr_accessor :directory
  #     
  #     def initialize
  #       @image_sizes = {}
  #     end
  #     
  #     def largest_file
  #       keys = @image_sizes.keys.sort
  #       @image_sizes[keys.last]
  #     end
  #     
  #     def fetch_images(url)
  #       #fix urls
  #       @directory ||= url.gsub(/[\/:]/, '')
  #       url = "http://#{url}/" unless /http:\/\//.match(url)
  #       full_path = "public/images/comics/" + @directory
  #       unless File.exists?(full_path)
  #         FileUtils.mkdir(full_path)
  #       end
  # 
  #       Nokogiri::HTML(open(url)).xpath("//img").collect do |n|
  #         file_url = n.attributes["src"]
  #         save_file(url, file_url)
  #       end
  #     end
  #     
  #     def save_file(url, file_uri)
  #       file_path = "public/images/comics/#{@directory}/#{file_uri.content.gsub(/[\/:]/, '_')}"
  #       image_path = "comics/#{@directory}/#{file_uri.content.gsub(/[\/:]/, '_')}"
  #       file_uri = file_uri.content 
  #       
  #       #if it is a local url add to the base 
  #       if /^\//.match(file_uri)
  #         if /http:\/\/.*(\/.*\/)/.match(url)
  #           base, x = url.match(/(http:\/\/.*)(\/.*\/)/).captures
  #           url = "#{base}/"
  #         end 
  #         file_uri = url + file_uri.gsub(/^\//, '') 
  #       end
  #                
  #       #write image
  #       open(file_path, 'wb') { |file|              
  #         file.write(open(file_uri).read)
  #       }
  #       
  #       #Add to hash for finding the largest image later
  #       @image_sizes[File.size(file_path)] = image_path
  #       rescue Errno::ENOENT
  #         puts "file fail: #{file_uri} with url #{url} to #{file_path}"
  #     end
  # end
end