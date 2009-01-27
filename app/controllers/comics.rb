class Comics < Application
  # provides :xml, :yaml, :js

  def index
    name = params[:name]
    unless name.blank?
      @comics = Comic.all :title.like => "%#{name}%"
      wiki = Wikipedia::Page.new
      @wikipedia_results = wiki.search(name)
    else  
      @comics = Comic.all
      @wikipedia_results = []
    end
    display @comics
  end

  def show(url)
    @comic = Comic.first(:url => url)
    raise NotFound unless @comic
    display @comic
  end

  def new
    only_provides :html
    @comic = Comic.new
    display @comic
  end

  def edit(url)
    only_provides :html
    @comic = Comic.first(:url => url)
    raise NotFound unless @comic
    display @comic
  end

  def create(comic)
    @comic = Comic.new(comic)
    @comic.wiki_page = true if params[:wiki_page]
    if @comic.save
      redirect resource(@comic), :message => {:notice => "Comic was successfully created"}
    else
      message[:error] = "Comic failed to be created"
      render :new
    end
  end

  def update(url, comic)
    @comic = Comic.first(:url => url)
    raise NotFound unless @comic
    if @comic.update_attributes(comic)
       redirect resource(@comic)
    else
      display @comic, :edit
    end
  end

  def destroy(url)
    @comic = Comic.first(:url => url)
    raise NotFound unless @comic
    if @comic.destroy
      redirect resource(:comics)
    else
      raise InternalServerError
    end
  end

end # Comics
