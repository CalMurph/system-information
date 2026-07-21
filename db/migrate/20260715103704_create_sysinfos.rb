class CreateSysinfos < ActiveRecord::Migration[8.1]
  validates :json, presence: true
  def change
    create_table :sysinfos do |t|
      t.string :name
      t.string :rack_pos
      t.string :slots
      t.text :notes
      t.text :json

      t.timestamps
    end
  end
end
