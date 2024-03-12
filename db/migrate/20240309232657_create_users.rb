# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.uuid :idfa, null: false
      t.integer :ban_status, limit: 1, null: false, default: 0

      t.timestamps

      t.index :idfa, unique: true
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          ALTER TABLE users
          ADD CONSTRAINT ban_status_range CHECK (ban_status >= 0 AND ban_status <= 9);
        SQL
      end

      dir.down do
        execute <<-SQL.squish
          ALTER TABLE users
          DROP CONSTRAINT ban_status_range;
        SQL
      end
    end
  end
end
