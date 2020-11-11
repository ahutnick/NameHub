class ApplicationController < ActionController::Base
    include SessionsHelper
    include ActivitiesHelper
    
    def track_activity(trackable)
        current_user.activities.create! action: params[:action], trackable: trackable
    end
end
