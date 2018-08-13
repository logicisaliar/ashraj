class CreateJoinTableProductUse2 < ActiveRecord::Migration[5.2]
  def change
    create_join_table :products, :uses do |t|
      t.index [:product_id, :use_id]
      # t.index [:use_id, :product_id]
    end
  end
end
