class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :product_id, :null => false, :references => [:products, :id]
      t.integer :user_id, :null => false, :references => [:users, :id]
      t.text :description
      t.integer :rating

      t.timestamps null: false
    end
  end
end
