## Modified version of http://github.com/seamusabshere/slugify/
module PrettyUrl
  def pretty_url(string)
    s = string.gsub(/\s+/, ' ')
    s.strip!
    s.gsub!(' ', '_')
    s.gsub!(/[^\w-]/u, '')
    s.downcase
  end
end