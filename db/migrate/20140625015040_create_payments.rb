class CreatePayments < ActiveRecord::Migration
  def up
    create_table :payments do |t|
      t.integer :amount_in_cents, null: false
      t.string :payment_type, null: false
      t.integer :client_id, null: false
      t.text :note

      t.timestamps
    end
  end

  def down
    drop_table :payments
  end
end
