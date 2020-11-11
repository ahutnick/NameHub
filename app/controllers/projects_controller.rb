class ProjectsController < ApplicationController
    
    def new 
        @project = current_user.projects.build
    end

    def create
        @project = current_user.projects.build(project_params)
        if @project.save
            track_activity @project
            flash[:success] = "Welcome to your new Project!"
            redirect_to(@project)
        else
            render 'new'
        end
    end

    def show
        @project = Project.find(params[:id])
        respond_to do |format|
            format.html
            format.json { render json: @project}
        end
    end

    def destroy
        @project = Project.find(params[:id])
        track_activity @project
        @project.destroy
        flash[:success] = "Project Deleted"
        redirect_back(fallback_location: current_user)
    end

    def edit
        @project = Project.find(params[:id])
    end

    def update
        @project = Project.find(params[:id])
        if @project.update(project_params)
          track_activity @project
          flash[:success] = "Project Updated"
          redirect_to @project
        else
          render 'edit'
        end
      end

    private
    def project_params
        params.require(:project).permit( :title,
                                         :description,
                                         :user_id)
    end
end
