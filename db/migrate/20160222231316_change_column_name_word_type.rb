class ChangeColumnNameWordType < ActiveRecord::Migration
  def change
  	rename_column :words, :type, :wordtype
  end
end
