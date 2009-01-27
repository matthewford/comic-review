class Comic
  include DataMapper::Resource
  include PrettyUrl
  
  property :id, Serial
  property :title, String
  property :url, String
  property :description, Text
  
  attr_accessor :wiki_page
  
  before :save, :populate_description
  before :save, :generate_url
  before :save, :parse_markdown
  
  def populate_description
    if wiki_page
      w = Wikipedia::Page.new
      p1, p2 = w.scrape(self.title)
      self.description = %(<p>#{p1}</p><p>#{p2}</p>)
    end
  end
  
  def generate_url
    self.url ||= pretty_url(self.title)
  end
  
  def parse_markdown
    self.description = RDiscount.new(self.description).to_html
  end  
end
