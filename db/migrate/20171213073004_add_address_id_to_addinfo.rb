class AddAddressIdToAddinfo < ActiveRecord::Migration
  def change
    add_column :addinfos, :address_id, :integer
  end
end
