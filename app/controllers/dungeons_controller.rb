class DungeonsController < ApplicationController
  def index
    @dungeons = Dungeon.take(100)
  end

  def show
    @dungeon = Dungeon.find(params[:id])
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

  private

  def dungeon_params
    params.require(:dungeon).permit(:level, :description, :author_name, :image)
  end
end
