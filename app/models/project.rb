class Project < ApplicationRecord
  has_many :employee_projects
  has_many :employees, :through => :employee_projects, dependent: :destroy
  validates :name, presence: true

  before_save(:titleize_name)

  scope :most_employees, -> {(
    select("projects.id, projects.name, count(employees.id) as employees_count")
    .joins(:employees)
    .group("projects.id")
    .order("employees_count DESC")
    .limit(10)
  )}

  private
  def titleize_name
    self.name = self.name.split(' ').map! { |w|
      (w[0] =~ /[a-z]/i) ? (w[0].upcase + w.slice(1, w.length)) : w
    }.join(' ')
  end
end
