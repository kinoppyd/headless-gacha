class DropAndRecreateGachas < ActiveRecord::Migration[7.0]
  # NEVER GO BACK

  def up
    drop_table :gachas, if_exists: true

    create_table :gachas, id: false do |t|
      t.string "id", limit: 36, null: false, primary_key: true
      t.string "items", array: true
      t.string "seed"
      t.timestamps
    end
  end

  def down
    drop_table :gachas, if_exists: true

    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gachas, id: :uuid do |t|
      t.string "items", array: true
      t.string "seed"
      t.timestamps
    end
  end
end
