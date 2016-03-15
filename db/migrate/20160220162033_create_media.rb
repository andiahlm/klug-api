class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :name
      t.string :type
      t.string :url
      t.string :identifier
      t.text :transcript

      t.timestamps null: false
    end
  end
end
