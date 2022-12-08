class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :payment_method, null: false
      t.string :payment_id, null: false
      t.string :reference, null: false
      t.string :amount, null: false, default: 0
      t.string :currency, null: false, default: "COP"
      t.string :rider_email, null: false
      t.timestamps
    end
  end
end
