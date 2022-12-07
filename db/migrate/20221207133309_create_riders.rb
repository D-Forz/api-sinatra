class CreateRiders < ActiveRecord::Migration[7.0]
  def change
    create_table :riders do |t|
      t.string :username, null: false, unique: true, default: "rider"
      t.string :password, null: false, default: "rider"
      t.string :email, null: false, unique: true
      t.jsonb :location, default: {}
      t.string :payment_method, default: "CARD"
      t.string :status, null: false, default: "AVAILABLE"
      t.timestamps
    end
  end
end
