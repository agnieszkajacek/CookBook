class AddUrlToRecipe < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.string :url
    end
  end
end
