class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User', foreign_key: 'user_id', optional: true

  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  has_many :comments
  
  validates :name, presence: true
  validates :description, presence: true
  validates :days, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  def send_task_updated_notification
    project_owner_email = project.user.email
    project_owner_name = project.user.name
    ProjectMailer.task_updated(self, project_owner_email, project_owner_name).deliver_now
  end
end
