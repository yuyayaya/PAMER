class AddImageToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :image, :string
  end
end
