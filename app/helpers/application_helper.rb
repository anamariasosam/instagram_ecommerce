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

  def is_store?
    current_user.type == "Store"
  end

  def active_link_to(anchor, href, classes, icon = false)
    content_tag :li, class: "dashboard__item" do
      link_to href, class: "#{classes} #{'active' if current_page?(href)}" do
        content_tag(:i, '',class: ["fa", "fa-#{icon}"]) +
        content_tag(:span, anchor, class: 'hidden-xs')
      end
    end
  end
end
