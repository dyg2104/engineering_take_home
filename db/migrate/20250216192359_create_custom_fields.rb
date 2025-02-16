class CreateCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_fields do |t|
      t.string :field_type
      t.bigint :client_id

      t.timestamps
    end
  end
end
