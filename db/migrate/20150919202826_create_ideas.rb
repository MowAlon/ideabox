class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
  end
end
