class Project::Repository
  def self.by_user_ordered_by_name(user)
    user.projects.order(name: :asc)
  end
end