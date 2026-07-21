class Datum < ApplicationRecord
  belongs_to :sysinfo, foreign_key: true
end
