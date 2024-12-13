class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles, id: :uuid do |t|
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.string :title, null: false
      t.string :level
      t.string :tag

      t.timestamps
    end
  end
end