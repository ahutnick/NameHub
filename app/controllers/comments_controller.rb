class CommentsController < ApplicationController
    before_action :get_task

    def create
        @comment = @task.comments.build(comment_params)
        if @comment.save
            track_activity @comment
            flash[:success] = "New Comment Added!"
            redirect_back(fallback_location: 'tasks#show')
        else
            render 'tasks/show'
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        track_activity @comment
        Comment.find(params[:id]).destroy
        flash[:success] = "Comment Deleted"
        redirect_back(fallback_location: 'tasks#show')
    end

    private
    def comment_params
        params.require(:comment).permit(:content,
                                        :task_id)
    end
    
    def get_task
        @task = Task.find(params[:task_id])
    end
end
