class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :description, null: false, default: ""
      t.string :url, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
