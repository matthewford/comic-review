class Users < Application
  # provides :xml, :yaml, :js
  before :ensure_authenticated, :exclude => [:index, :show, :new, :create]

  def index
    @users = User.all
    display @users
  end

  def show(username)
    @user = User.first(:username => username)
    raise NotFound unless @user
    display @user
  end

  def new
    only_provides :html
    @user = User.new
    display @user
  end

  def edit(username)
    only_provides :html
    @user = User.first(:username => username)
    raise NotFound unless @user
    display @user
  end

  def create(user)
    @user = User.new(user)
    if @user.save
      redirect url(:homepage), :message => {:success => "User was successfully created"}
    else
      message[:error] = "User failed to be created"
      render :new
    end
  end

  def update(username, user)
    @user = User.first(:username => username)
    raise NotFound unless @user
    if @user.update_attributes(user)
       redirect resource(@user)
    else
      display @user, :edit
    end
  end

  def destroy(username)
    @user = User.first(:username => username)
    raise NotFound unless @user
    if @user.destroy
      redirect url(:homepage), :message => {:notice => "Sorry to see you go..."}    
    else
      raise InternalServerError
    end
  end

end # Users
