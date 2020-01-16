class Division < ApplicationRecord
  has_many :employees, dependent: :destroy
  validates :name, presence: true

  before_save(:titleize_name)

  private
  def titleize_name
    self.name = self.name.split(' ').map! { |w|
      (w[0] =~ /[a-z]/i) ? (w[0].upcase + w.slice(1, w.length)) : w
    }.join(' ')
  end

end
