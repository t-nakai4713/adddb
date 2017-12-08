class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.inet :ipadd
      t.string :use, default:"free"
      t.integer :status, null: false, default: 0
      t.integer :type
      t.timestamps null: false
    end
  end
end
