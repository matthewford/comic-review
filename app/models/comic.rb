class Comic
  include DataMapper::Resource
  include PrettyUrl
  
  property :id, Serial
  property :title, String, :nullable => false
  property :url, String
  property :description, Text
  property :image_url, Text
  
  validates_is_unique :url, :title
  
  attr_accessor :wiki_page, :new_tag
  
  before :save, :populate_description
  before :save, :generate_url
  before :save, :parse_markdown
  
  has n, :comments
  
  has_tags_on :tags
  
  def populate_description
    if wiki_page
      #description
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
  
  #for split stars
  def calculate_total_rating
    (self.comments.avg(:rating) * 4).round
  end  
end
