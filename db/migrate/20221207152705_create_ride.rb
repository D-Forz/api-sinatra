class CreateRide < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.jsonb :origin, null: false, default: {}
      t.jsonb :destination, default: {}
      t.belongs_to :rider, null: false
      t.belongs_to :driver
      t.timestamps
    end
  end
end
