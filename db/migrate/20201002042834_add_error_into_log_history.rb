class AddErrorIntoLogHistory < ActiveRecord::Migration[6.0]
  def change
    add_column :log_histories, :error, :text
  end
end
