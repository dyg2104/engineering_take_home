class CreateBuildingCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :building_custom_fields do |t|
      t.timestamps
    end
  end
end
