class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher
  validates :label, presence: true
  validates :command, presence: true

  enum kind: { open: 0, multiple: 1 }

end
