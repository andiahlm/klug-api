class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.integer :rank
      t.string :type
      t.decimal :dispersion
      t.integer :level
      t.string :translation

      t.timestamps null: false
    end
  end
end
