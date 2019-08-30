class AddEventLenghtToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_length, :integer
  end
end
