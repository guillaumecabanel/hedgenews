module SearchBarHelper
  def hidden_bar_class
    hidden = ""
    if current_page?(root_path) || controller_name == 'articles'
      hidden = "hidden"
    end
    hidden
  end

  def hidden_bar_id
    id = ""
    if current_page?(root_path) || controller_name == 'articles'
      id = "navbar-search"
    end
    id
  end
end
