class AddImageToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column(:employees, :image, :string)
  end
end
