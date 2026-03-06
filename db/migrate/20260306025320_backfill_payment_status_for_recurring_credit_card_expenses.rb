class BackfillPaymentStatusForRecurringCreditCardExpenses < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      UPDATE expenses
      SET payment_status = 'scheduled'
      WHERE recurring = TRUE
        AND payment_method = 'credit_card'
        AND payment_status IS NULL
    SQL
  end

  def down
    execute <<~SQL
      UPDATE expenses
      SET payment_status = NULL
      WHERE recurring = TRUE
        AND payment_method = 'credit_card'
        AND payment_status = 'scheduled'
    SQL
  end
end
