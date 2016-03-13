class CreateUserwords < ActiveRecord::Migration
  def change
    create_table :userwords do |t|
      t.integer :strength
      t.references :user, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
