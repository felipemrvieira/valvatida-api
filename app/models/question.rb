class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher
  validates :label, presence: true
  validates :command, presence: true
end
