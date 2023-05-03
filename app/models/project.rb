class Project < ApplicationRecord
  belongs_to :user
  belongs_to :project_manager, class_name: 'User', optional: true

  has_many :tasks
  has_many :comments

  has_many :team_assignments
  has_many :team_members, through: :team_assignments, source: :user

  after_update :send_project_updated_notification

  def send_project_updated_notification(current_user)
    project_manager_email = User.where(role: 'project_manager').pluck(:email)
    project_manager_name = User.find_by(email: project_manager_email)&.name
    ProjectMailer.project_updated(self, project_manager_email, project_manager_name, current_user).deliver_now
  end 
end
