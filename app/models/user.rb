class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # enum role: [:admin, :project_manager, :team_member]
  enum role: { admin: "admin", project_manager: "project_manager", team_member: "team_member" }
  has_many :projects, dependent: :destroy
  has_many :comments
  has_many :tasks
  has_many :notifications

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  has_many :assigned_projects, through: :team_assignments, source: :project

  def full_name
    "#{first_name} #{last_name}"
  end
end
