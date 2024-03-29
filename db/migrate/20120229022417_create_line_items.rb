class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :product_id, :null => false, :option => "CONSTRAINT fk_line_item_products REFERENCES products(id)"
      t.integer :order_id, :null => false, :option => "CONSTRAINT fk_line_item_products REFERENCES order(id)"
      t.integer :quantity, :null => false
      t.decimal :total_price, :null => false, :precision => 8, :scale => 2 

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
