class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
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
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end 

  def destroy
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
end
