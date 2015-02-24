class DungeonsController < ApplicationController
  before_action :find_dungeon, only: %i(show upvote downvote)

  def index
    @dungeons = Dungeon.by_rating.take(100)
  end

  def show
  end

  def new
    @dungeon = Dungeon.new
  end

  def create
    @dungeon = Dungeon.new(dungeon_params)

    if @dungeon.save!
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

  def dungeon_params
    params.require(:dungeon).permit(:level, :description, :author_name, :image)
  end

  def find_dungeon
    @dungeon = Dungeon.find(params[:id])
  end
end
