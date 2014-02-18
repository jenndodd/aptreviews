class BreakUpAddress < ActiveRecord::Migration
  def change
    change_table :apartments do |t|
      t.remove :address
      t.string :number
      t.string :street
      t.string :city
      t.string :state
    end
  end
end
