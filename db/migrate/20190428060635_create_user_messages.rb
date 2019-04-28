class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.string :username, null: false
      t.string :provider, null: false
      t.string :message, null: false
      t.string :uuid, null: false
      t.string :status, null: false, default: 'queued'
      t.integer :retry_count, null: false, default: 0
      t.datetime :retried_at
      t.datetime :send_at
      t.timestamps
    end

    add_index :user_messages, :uuid, using: :hash
    add_index :user_messages, :status
  end
end
