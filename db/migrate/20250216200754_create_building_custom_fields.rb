class CreateBuildingCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :building_custom_fields do |t|
      t.string :field_type
      t.string :value
      t.bigint :building_id

      t.timestamps
    end
  end
end
