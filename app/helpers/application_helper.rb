module ApplicationHelper
  def markdown(text)
    Thread.current[:markdown] ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: false)
    raw Thread.current[:markdown].render(text)
  end

  def can_vote?(dungeon)
    !session[:votes].to_a.include?(dungeon.id)
  end
end
