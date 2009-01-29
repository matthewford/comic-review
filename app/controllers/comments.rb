class Comments < Application
  # provides :xml, :yaml, :js
  before :find_comic

   def edit(id)
    only_provides :html
    @comment = Comment.get(id)
    raise NotFound unless @comment
    display @comment
  end

  def create(comment)
    @comment = @comic.comments.build(comment)
    @comment.user = session.user
    if @comment.save
      redirect resource(@comic), :message => {:success => "Comment was successfully created"}
    else
      redirect resource(@comic), :message => {:success => "Comment failed to be created"}
    end
  end

  def update(id, comment)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.update_attributes(comment)
       redirect resource(@comic)
    else
      display @comment, :edit
    end
  end

  def destroy(id)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.destroy
      redirect resource(:comments)
    else
      raise InternalServerError
    end
  end

  private 
  def find_comic
    @comic = Comic.first(:url => params[:url])
  end

end # Comments
