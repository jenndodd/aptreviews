class AddAddressColumntoApartments < ActiveRecord::Migration
  def change
    change_table :apartments do |t|
      t.string :address
    end
  end
end
