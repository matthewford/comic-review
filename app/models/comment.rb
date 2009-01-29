class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :body, Text
  property :body_html, Text
  property :rating, Integer

  before :save, :parse_markdown
  
  belongs_to :comic
  belongs_to :user
  
  def parse_markdown
    self.body_html = RDiscount.new(self.body).to_html
  end

end
