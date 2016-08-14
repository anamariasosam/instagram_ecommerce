module ApplicationHelper
  def sortable(title, column)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? sort_direction == "asc" ? "down" : "up" : "down"

    link_to params.merge(sort: column, direction: direction) do
      title.html_safe + ' ' +
      content_tag(:small, '',class: "glyphicon glyphicon-chevron-#{css_class}")
    end
  end

  def link_to_if(*args,&block)
    args.insert 1, capture(&block) if block_given?

    super *args
  end
end
