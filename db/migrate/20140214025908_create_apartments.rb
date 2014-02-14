class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :address
      t.string :unit
      t.integer :lat
      t.integer :long
    end
  end
end
