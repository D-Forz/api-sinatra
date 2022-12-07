class CreateRide < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.string :start, null: false
      t.string :finish, null: false
      t.belongs_to :rider, null: false
      t.belongs_to :driver, null: false
      t.timestamps
    end
  end
end
