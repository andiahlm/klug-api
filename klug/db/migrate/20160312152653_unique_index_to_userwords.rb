class UniqueIndexToUserwords < ActiveRecord::Migration
  def change
  	add_index :userwords, [:user_id, :word_id], :unique => true
  end
end
