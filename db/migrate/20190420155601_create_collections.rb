class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.integer :collection_id
      t.integer :size
      t.string :name
      t.timestamps
    end
  end
end