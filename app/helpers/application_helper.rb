module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Hotels"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

  def sort_link(sort)
    if params[:sort_by] == "#{sort}_asc"
      link_to sort, admin_path(sort_by: "#{sort}_desc")
    else
      link_to sort, admin_path(sort_by: "#{sort}_asc")
    end
  end
  
end