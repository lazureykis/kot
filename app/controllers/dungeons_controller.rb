class DungeonsController < ApplicationController
  before_action :find_dungeon, only: %i(show upvote downvote)
  LIMIT = 100

  def index
    @mode = :best
    render_dungeons
  end

  def latest
    @mode = :latest
    render_dungeons
  end

  def show
  end

  def new
    @dungeon = Dungeon.new
  end

  def create
    @dungeon = Dungeon.new(dungeon_params)
    build_photos

    if @dungeon.save
      redirect_to dungeon_path(@dungeon)
    else
      render action: :new
    end
  end

  def upvote
    @dungeon.upvote!
    after_vote
  end

  def downvote
    @dungeon.downvote!
    after_vote
  end

  private

  def after_vote
    session[:votes] ||= []
    session[:votes].push(@dungeon.id)
    redirect_to :back
  end

  def build_photos
    params[:images].to_a.each do |image|
      @dungeon.photos << AdditionalPhoto.new(image: image, dungeon: @dungeon)
    end
  end

  def dungeon_params
    params.require(:dungeon).permit(:level, :description, :author_name, :image)
  end

  def find_dungeon
    @dungeon = Dungeon.find(params[:id])
  end

  def find_level
    @level = params[:level].present? ? params[:level].to_i : nil
  end

  def render_dungeons
    find_level

    @dungeons = Dungeon.includes(:photos).send(@mode)
    @dungeons = @dungeons.where(level: @level) if @level.present?
    @fungeons = @dungeons.take(LIMIT)

    render action: :index
  end
end
