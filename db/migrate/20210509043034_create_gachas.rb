class CreateGachas < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gachas, id: :uuid do |t|
      t.string "items", array: true
      t.string "seed"
      t.timestamps
    end
  end
end
