class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :kind, null: false
      t.timestamps
    end

    add_index :providers, :kind, unique: true

    create_table :messages do |t|
      t.integer :users_provider_id, null: false
      t.string :body, null: false
      t.timestamps
    end

    add_index :messages, [:users_provider_id, :body], unique: true

    create_table :users_providers do |t|
      t.integer :user_id, null: false
      t.integer :provider_id, null: false
      t.string :username, null: false
      t.timestamps
    end

    add_index :users_providers, [:user_id, :provider_id], unique: true
  end
end
