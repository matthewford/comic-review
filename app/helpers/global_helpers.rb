module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    include GravatarHelper::PublicMethods
    include PrettyUrl
    
    def tab_selected?(url)
      "selected" if request.path == url
    end
    
  end
end
