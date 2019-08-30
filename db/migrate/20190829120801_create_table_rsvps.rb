class CreateTableRsvps < ActiveRecord::Migration[5.2]
  def change
    create_table :rsvps do |t|
      t.references :event
      t.references :user
      t.integer :status

      t.timestamps
    end
  end

end
