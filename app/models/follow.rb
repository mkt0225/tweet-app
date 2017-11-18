class Follow < ApplicationRecord
  validates :follow_by, {presence: true}
  validates :follow_to, {presence: true}
end
