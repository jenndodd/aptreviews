class RenameLatLong < ActiveRecord::Migration
  def change
    change_table :apartments do |t|
      t.remove :lat
      t.remove :long
      t.float :latitude
      t.float :longitude
    end
  end
end
