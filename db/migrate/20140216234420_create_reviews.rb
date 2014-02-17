class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.datetime :datetime
      t.integer :rating
      t.references :user
      t.references :apartment
    end
  end
end
