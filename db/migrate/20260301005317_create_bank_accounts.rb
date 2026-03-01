class CreateBankAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :bank_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :bank_name
      t.string :account_type, null: false, default: "checking"
      t.decimal :balance, precision: 15, scale: 2, default: 0
      t.decimal :interest_rate, precision: 8, scale: 4, default: 0
      t.string :currency, default: "BRL"
      t.string :color, default: "#6C63FF"

      t.timestamps
    end
  end
end
