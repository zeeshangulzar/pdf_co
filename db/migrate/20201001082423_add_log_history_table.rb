class AddLogHistoryTable < ActiveRecord::Migration[6.0]
  def change
    create_table :log_histories do |t|
      t.string :path
      t.string :http_type
      t.json :request_parameters
      t.json :response_parameters
      t.string :response_code

      t.timestamps
    end

    add_index :log_histories, :path
    add_index :log_histories, :response_code
    add_index :log_histories, :http_type
  end
end
