class CreateIdeaImages < ActiveRecord::Migration
  def change
    create_table :idea_images do |t|
      t.references :image, index: true, foreign_key: true
      t.references :idea, index: true, foreign_key: true
    end
  end
end
