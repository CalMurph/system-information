class CreateJsons < ActiveRecord::Migration[8.1]
   validates :json, presence: true
  def change
    create_table :jsons do |t|
      t.text :json
      t.references :sysinfo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
