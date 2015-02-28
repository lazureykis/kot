module DungeonsHelper
  def can_vote?(dungeon)
    !session[:votes].to_a.include?(dungeon.id)
  end

  def current_level
    if @level
      "[#{@level}] #{Dungeon::LEVELS[@level.to_i]}"
    else
      'All levels'
    end
  end
end