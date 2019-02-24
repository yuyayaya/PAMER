class AddTagToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :tag, :string
  end
end
