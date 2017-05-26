module SearchBarHelper
  def hidden_bar_class
    hidden = ""
    if current_page?(root_path) || current_page?(controller: 'articles')
      hidden = "hidden"
    end
    hidden
  end

  def hidden_bar_id
    id = ""
    if current_page?(root_path) || current_page?(controller: 'articles')
      id = "navbar-search"
    end
    id
  end
end
