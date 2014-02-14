class ChangeCoordinateTypes < ActiveRecord::Migration
  def change
    change_table :apartments do |t|
      t.remove :lat
      t.remove :long
      t.float :lat
      t.float :long
    end
  end
end
