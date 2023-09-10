class RemoveStatusFromTodos < ActiveRecord::Migration[7.0]
  def change
    remove_column :todos, :status, :boolean
  end
end
