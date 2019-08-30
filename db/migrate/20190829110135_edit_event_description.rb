class EditEventDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :desc, :description
  end
end
