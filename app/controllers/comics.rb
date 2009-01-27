class Comics < Application
  # provides :xml, :yaml, :js

  def index
    @comics = Comic.all
    display @comics
  end

  def show(id)
    @comic = Comic.get(id)
    raise NotFound unless @comic
    display @comic
  end

  def new
    only_provides :html
    @comic = Comic.new
    display @comic
  end

  def edit(id)
    only_provides :html
    @comic = Comic.get(id)
    raise NotFound unless @comic
    display @comic
  end

  def create(comic)
    @comic = Comic.new(comic)
    if @comic.save
      redirect resource(@comic), :message => {:notice => "Comic was successfully created"}
    else
      message[:error] = "Comic failed to be created"
      render :new
    end
  end

  def update(id, comic)
    @comic = Comic.get(id)
    raise NotFound unless @comic
    if @comic.update_attributes(comic)
       redirect resource(@comic)
    else
      display @comic, :edit
    end
  end

  def destroy(id)
    @comic = Comic.get(id)
    raise NotFound unless @comic
    if @comic.destroy
      redirect resource(:comics)
    else
      raise InternalServerError
    end
  end

end # Comics
