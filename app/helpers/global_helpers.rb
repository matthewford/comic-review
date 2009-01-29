module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    include GravatarHelper::PublicMethods
    include PrettyUrl
    
    def tab_selected?(url)
      "selected" if request.path == url
    end
    
    def stars(star_no)
      star_no = star_no.to_i
      inputs = (1..5).collect do |i|
    	  %(<div class="star #{"star_on" if i<=star_no}">
    	    <a></a>
    	  </div>)
      end
    end
    
  end
end
