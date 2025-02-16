class RenameFieldTypeOnBuildingCustomField < ActiveRecord::Migration[7.2]
  def change
    rename_column :building_custom_fields, :field_type, :name
  end
end
