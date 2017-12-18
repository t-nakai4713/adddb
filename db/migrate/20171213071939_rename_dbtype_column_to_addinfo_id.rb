class RenameDbtypeColumnToAddinfoId < ActiveRecord::Migration
  def change
   rename_column :addresses, :dbtype, :addinfo_id
  end
end
