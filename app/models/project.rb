class Project < ApplicationRecord
  belongs_to :user
  belongs_to :project_manager, class_name: 'User', optional: true

  has_many :tasks
  has_many :comments

  has_many :team_assignments
  has_many :team_members, through: :team_assignments, source: :user
end
