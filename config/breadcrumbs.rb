crumb :root do
  link 'Home', root_path
end

crumb :organizations do
  link 'Organizations', organizations_path
  parent :root
end

crumb :organization do |organization|
  link organization.name, organization
  parent :organizations
end

crumb :tests do
  link 'Tests', tests_path
  parent :root
end

crumb :test do |test|
  link test.name, test_path(test)
  parent :tests
end

crumb :edit_test do |test|
  link 'Edit', edit_test_path(test)
  parent :test, test
end

crumb :new_test do
  link 'New', new_test_path
  parent :tests
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).