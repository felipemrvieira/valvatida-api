class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher
  has_many :open_question_answers, dependent: :nullify
  has_many :multiple_question_options, dependent: :nullify
  has_many :attempts, dependent: :nullify
  
  enum kind: { open: 0, multiple: 1 }
  
  validates :label, presence: true
  validates :command, presence: true



end
