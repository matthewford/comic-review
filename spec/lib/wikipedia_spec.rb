require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Wikipedia do
  
  before do
    @wiki = Wikipedia::Page.new
  end
        
  it "should search wikipedia and return search results" do
    stub_http_response_with('xkcd.json')
    @wiki.search('xkcd').should == ["XKCD", "Xkcd", "Xkcd.com"]
  end
  
  it "should return an empty array if search returned no results" do
    stub_http_response_with('badquery.json')
    @wiki.search('badquery').should == []
  end
  
  it "should raise an error if nothing is searched for" do
    lambda{@wiki.search("")}.should raise_error(ArgumentError)
  end
  
  it "should scrape the first two paragraphs of a page in plane text" do
    file = File.open(File.join(File.dirname(__FILE__),"xkcd_html_dump"), "rb")
    contents = file.read
    @wiki.should_receive(:open).and_return(contents)
    
    paragraph1, paragraph2 = @wiki.scrape("XKCD")
    paragraph1.should == "xkcd is a webcomic created by Randall Munroe, a former contractor for NASA. He describes it as a webcomic of romance, sarcasm, math, and language.xkcd is a widely read webcomic (it tallied between 60 and 70 million page views during October 2007 ) and has been recognized in mainstream media such as The Guardian."
    paragraph2.should == "Munroe states there is no particular meaning to the name and it is simply a four-letter word without a phonetic pronunciation, something he describes as a treasured and carefully-guarded point in the space of four-character strings. The subjects of the comics themselves vary. Some are statements on life and love (some love strips are simply art with poetry), and some are mathematical or scientific in-jokes. Some strips feature simple humor or pop-culture references. Although it has a cast of stick figures, the comic occasionally features landscapes, intricate mathematical patterns such as fractals (for example, strip #17 What If shows an Apollonian gasket), or imitations of the style of other cartoonists (as during parody week). Occasionally, realism is featured."
  end
  
end

