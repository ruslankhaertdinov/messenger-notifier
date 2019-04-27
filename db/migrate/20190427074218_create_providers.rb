class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :slug, null: false
      t.integer :kind, null: false
      t.timestamps
    end

    add_index :providers, :kind, unique: true

    create_table :messages do |t|
      t.integer :providers_user_id, null: false
      t.string :body, null: false
      t.timestamps
    end

    add_index :messages, [:providers_user_id, :body], unique: true

    create_table :providers_users do |t|
      t.integer :provider_id, null: false
      t.integer :user_id, null: false
      t.string :username, null: false
      t.timestamps
    end

    add_index :providers_users, [:provider_id, :user_id], unique: true
  end
end
