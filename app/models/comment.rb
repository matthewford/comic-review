class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :body, Text, :nullable => false
  property :body_html, Text
  property :rating, Integer

  before :save, :parse_markdown
  
  validates_present :user_id, :comic_id
  
  belongs_to :comic
  belongs_to :user
  
  def parse_markdown
    self.body_html = RDiscount.new(self.body).to_html
  end

end
