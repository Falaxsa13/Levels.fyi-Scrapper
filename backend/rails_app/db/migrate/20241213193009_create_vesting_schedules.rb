class CreateVestingSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :vesting_schedules, id: :uuid do |t|
      t.references :compensation, null: false, foreign_key: true, type: :uuid
      t.integer :year
      t.decimal :amount, precision: 12, scale: 2
      t.decimal :percentage, precision: 5, scale: 2

      t.timestamps
    end
  end
end