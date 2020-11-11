class ActivitiesController < ApplicationController
    private
    def activity_params
        params.require(:activity).permit(:action, :trackable)
    end
end
