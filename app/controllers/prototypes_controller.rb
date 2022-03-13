class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new     
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    unless user_signed_in?
      redirect_to :move_to_index
    else
    @prototype = Prototype.find(params[:id])
    end
  end

  def update
    #PicTweetでは一度保存してしまえばフォームとやりとりすることがないので、
    #@がついたインスタンス変数ではなく、変数prototypeにしている。
    #しかしProtospaceでは、render :editでフォームとのやり取りを伴うので
    #@がついたインスタンス変数@prototypeにする
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end

