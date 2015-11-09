crumb :root do
  link 'Home', root_path
end

crumb :organizations do
  link 'Organizations', organizations_path
  parent :root
end

crumb :organization do |organization|
  link organization.name, organization_path(organization)
  parent :organizations
end

crumb :new_organization do
  link 'New', new_organization_path
  parent :organizations
end

crumb :organization_projects do |organization|
  link 'Projects', organization_projects_path
  parent :organization, organization
end

crumb :organization_project do |project|
  link project.name, organization_project_path(project.organization.id, project.id)
  parent :organization_projects, project.organization
end

crumb :new_organization_project do |organization|
  link 'New', new_organization_project_path(organization)
  parent :organization_projects, organization
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