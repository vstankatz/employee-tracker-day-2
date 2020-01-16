class Project < ApplicationRecord
  has_many :employee_projects
  has_many :employees, :through => :employee_projects, dependent: :destroy

  scope :most_employees, -> {(
    select("projects.id, projects.name, count(employees.id) as employees_count")
    .joins(:employees)
    .group("projects.id")
    .order("employees_count DESC")
    .limit(10)
  )}
end
