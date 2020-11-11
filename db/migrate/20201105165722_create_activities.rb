class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :action
      t.references :trackable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
