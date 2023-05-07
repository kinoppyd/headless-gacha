class ChangeColumnTypeFromJsonToString < ActiveRecord::Migration[7.0]
  def up
    change_table :gachas do |t|
      t.change :items, :json, using: 'to_json(items)::json'
    end
  end

  def down
    function = <<~SQL
    CREATE OR REPLACE FUNCTION json_arr2varchar_arr(_js json)
      RETURNS varchar[] LANGUAGE sql IMMUTABLE PARALLEL SAFE AS
    'SELECT ARRAY(SELECT json_array_elements_text(_js)::varchar)';
    SQL
    ActiveRecord::Base.connection.execute(function)
    change_table :gachas do |t|
      t.change :items, :string, array: true, using: 'json_arr2varchar_arr(items)'
    end
  end
end
