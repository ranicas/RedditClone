class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.references :post, index: true
      t.references :sub, index: true

      t.timestamps
    end
  end
end
