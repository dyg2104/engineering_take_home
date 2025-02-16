class CreateCustomFieldValues < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_field_values do |t|
      t.bigint :custom_field_id
      t.string :value

      t.timestamps
    end
  end
end
