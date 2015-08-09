class AddUrlToRecipe < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.string :urlrake 
    end
  end
end
