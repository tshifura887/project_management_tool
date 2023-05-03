class ProjectMailer < ActionMailer::Base
    default from: 'tshifura887@gmail.com'
    
    def project_updated(project, project_manager_email, project_manager_name)
      @project = project
      @project_manager_name = project_manager_name
      mail(to: project_manager_email, subject: "Project Updated: #{project.name}")
    end
  end
  