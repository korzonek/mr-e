class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :name
      t.text :description
      t.boolean :is_published, default: false
      t.boolean :is_solved, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
