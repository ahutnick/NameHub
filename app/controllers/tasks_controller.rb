class TasksController < ApplicationController
    before_action :get_project
    
    def new
        @task = @project.tasks.build
    end

    def create
        @task = @project.tasks.build(task_params)
        if @task.save
            flash[:success] = "Task Created!"
            redirect_to(@project)
        else
            render 'new'
        end
    end

    def index
        @tasks = @project.tasks
        respond_to do |format|
            format.json { render json: @tasks}
        end
    end

    def show
        @task = Task.find(params[:id])
        @comment = @task.comments.build
        
    end

    def destroy
        Task.find(params[:id]).destroy
        flash[:success] = "Task Deleted"
        redirect_to @project
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:success] = "Task Updated"
            redirect_to project_task_path
        else
            render 'edit'
        end
    end


    private
    def task_params
        params.require(:task).permit( :title,
                                      :project_id,
                                      :stage,
                                      :description)
    end

    def get_project
        @project = Project.find(params[:project_id])
    end
end
