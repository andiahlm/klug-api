class WordsAddColumnActive < ActiveRecord::Migration
  def change
  	add_column :words, :active, :boolean
  end
end
