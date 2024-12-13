class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers, id: :uuid do |t|
      t.references :role, null: false, foreign_key: true, type: :uuid
      t.date :offer_date
      t.string :location
      t.string :employment_type
      t.string :work_mode
      t.integer :years_at_company
      t.integer :years_of_experience

      t.timestamps
    end
  end
end,