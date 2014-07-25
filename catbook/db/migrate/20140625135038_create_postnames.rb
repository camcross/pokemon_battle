class CreatePostnames < ActiveRecord::Migration
  def change
    create_table :postnames do |t|
      t.string :name
      t.string :body

      t.timestamps
    end
  end
end
