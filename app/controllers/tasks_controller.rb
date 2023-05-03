class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[ show edit update destroy ]

  load_and_authorize_resource

  # GET /tasks or /tasks.json
  def index
    @tasks = @project.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @project.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_url, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if params[:task][:attachments_attributes]
      params[:task][:attachments_attributes].each do |i, attachment_params|
        if attachment_params[:_destroy] == "1"
          @task.attachments.find(attachment_params[:id]).destroy
        end
      end
    end

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end  

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_attachment
    attachment = Attachment.find(params[:task_id])
    attachment.file.purge  # delete the attachment's file from storage
    attachment.destroy     # delete the attachment from the database
    redirect_back(fallback_location: project_task_path(@task.project, @task))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :days, :days_left, :priority, :status, :project_id, :user_id, attachments_attributes: [:id, :file, :_destroy])
    end
end
