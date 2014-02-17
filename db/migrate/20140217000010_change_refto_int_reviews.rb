class ChangeReftoIntReviews < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.remove_references :user
      t.remove_references :apartment 
      t.integer :user_id
      t.integer :apartment_id
    end
  end
end
