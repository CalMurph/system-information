class CreateData < ActiveRecord::Migration[8.1]
  def change
    create_table :data do |t|
      t.text :json
      t.references :sysinfo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
