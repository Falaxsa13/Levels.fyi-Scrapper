class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name, null: false
      t.string :website
      t.integer :year_founded
      t.integer :num_employees
      t.string :estimated_revenue
      t.text :description

      t.timestamps
    end
  end
end