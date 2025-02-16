class CreateBuildings < ActiveRecord::Migration[7.2]
  def change
    create_table :buildings do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.bigint :client_id

      t.timestamps
    end
  end
end
