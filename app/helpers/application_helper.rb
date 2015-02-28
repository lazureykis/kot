module ApplicationHelper
  def markdown(text)
    Thread.current[:markdown] ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: false)
    raw Thread.current[:markdown].render(text)
  end

  def current_page(page_name = nil, *args)
    @current_page = page_name if page_name
    @current_page
  end
end
