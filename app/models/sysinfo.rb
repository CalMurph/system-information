class Sysinfo < ApplicationRecord
  has_many :data, dependent: :destroy
  has_many :jsons, dependent: :destroy
end
