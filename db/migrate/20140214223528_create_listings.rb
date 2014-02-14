class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :url
      t.references :apartment
    end
  end
end
