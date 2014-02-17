class AddTitleToReviews < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.string :title
    end
  end
end
