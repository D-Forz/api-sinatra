class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :username, null: false, unique: true, default: "driver"
      t.string :password, null: false, default: "driver"
      t.string :status, null: false, default: "AVAILABLE"
      t.jsonb :location, default: {}
      t.timestamps
    end
  end
end
