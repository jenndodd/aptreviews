class AddStuffToApartments < ActiveRecord::Migration
  def change
    change_table :apartments do |t|
      t.string :beds
      t.string :baths
      t.string :rent
      t.text   :extras 
    end
  end
end
