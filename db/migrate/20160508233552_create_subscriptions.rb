class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions, id: false do |t|
      t.references :board, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
