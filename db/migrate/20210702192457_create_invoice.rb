class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :status

      t.timestamps
    end
  end
end
