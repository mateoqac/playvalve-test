class CreateIntegrityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :integrity_logs, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.uuid :idfa, null: false
      t.string :ban_status, null: false
      t.string :ip
      t.string :country
      t.boolean :rooted_device
      t.boolean :vpn, default: false
      t.boolean :proxy, default: false

      t.timestamps
    end

    add_foreign_key 'integrity_logs', 'users', column: 'idfa', primary_key: 'idfa', on_delete: :cascade
  end
end
