class AddSomeFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :university, :string
    add_column :users, :major, :string
    add_column :users, :hometown, :string
    add_column :users, :hobby, :string
    add_column :users, :detail, :text
    add_column :users, :picture, :string
  end
end
