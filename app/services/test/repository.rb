class Test::Repository
  def self.by_user_grouped(user)
    tests = user.tests.includes(project: :organization).order('tests.active desc, name asc')
    tests.group_by(&:project).sort_by { |project, _| [project.organization.name, project.name] }
  end
end