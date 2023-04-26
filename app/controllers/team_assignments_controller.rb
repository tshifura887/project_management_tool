class TeamAssignmentsController < ApplicationController
  load_and_authorize_resource

  def new
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @team_assignment = @project.team_assignments.build(team_assignment_params)

    if @team_assignment.save
      redirect_to @project, notice: 'Team member assigned successfully.'
    else
      render :new
    end
  end

  private

  def team_assignment_params
    params.require(:team_assignment).permit(:user_id)
  end
end
