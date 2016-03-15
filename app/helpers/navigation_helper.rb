module NavigationHelper
  def navigation_link(text, icon, url, controller)
    class_name = 'active' if controller && controller_name == controller.to_s
    content_tag(:li, class: class_name) do
      link_to url do
        concat content_tag(:i, nil, class: "fa #{icon}")
        concat content_tag(:span, text, class: 'nav-label')
      end
    end
  end

  def navigation_for_user_projects(user)
    class_name = 'active' if controller_name == 'projects'
      content_tag(:li, class: class_name) do
        capture do
          concat(link_to('#') do
            concat content_tag(:i, nil, class: 'fa fa-codepen')
            concat content_tag(:span, t('navigation.projects'), class: 'nav-label')
            concat content_tag(:span, nil, class: 'fa arrow')
          end)
          concat(content_tag(:ul, class: 'nav nav-second-level collapse') do
            user_projects(user).each do |project|
              project_class_name = 'active' if current_page?(organization_project_path(project.organization, project))
              concat content_tag(:li, link_to(project.name, organization_project_path(project.organization, project)), class: project_class_name)
            end
          end)
        end
    end
  end

  private

  def user_projects(user)
    user.projects.order(name: :asc)
  end
end