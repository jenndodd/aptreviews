class ApartmentsAddUserId < ActiveRecord::Migration
   def change
    change_table :apartments do |t|
      t.integer :user_id
    end
  end
end
