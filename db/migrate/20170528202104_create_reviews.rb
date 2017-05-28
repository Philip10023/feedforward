class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :message, null: false

      t.belongs_to :feed, null:false
      t.belongs_to :user, null:false
      t.belongs_to :updowns, default: 0

      t.timestamps
    end
  end
end
