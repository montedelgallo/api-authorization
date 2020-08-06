class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :controller
      t.string :action
      t.json :allowed_params

      t.timestamps
    end
  end
end
