class CreateAddinfos < ActiveRecord::Migration
  def change
    create_table :addinfos do |t|
      t.string :db_name, default: "DB名称"
      t.text :db_info, default: "DB用途説明"
      t.string :text_tpl1
      t.string :text_tpl2

      t.timestamps null: false
    end
  end
end
