class CreateCompensations < ActiveRecord::Migration[7.0]
  def change
    create_table :compensations, id: :uuid do |t|
      t.references :offer, null: false, foreign_key: true, type: :uuid
      t.decimal :base_salary, precision: 12, scale: 2
      t.decimal :stock_annual, precision: 12, scale: 2
      t.string :bonus
      t.decimal :stock_total, precision: 12, scale: 2

      t.timestamps
    end
  end
end