module ActivitiesHelper
    include SessionsHelper

    def action_ed(activity)
        activity.action == "destroy" ? @act = "Delete" : @act = activity.action
        @act[-1] == 'e' ? (@act.titleize + 'd') : (@act.titleize + 'ed')
    end

    def content_type(activity)
        return if activity.action == "destroy" 
        activity.trackable_type == 'Comment' ? ': ' + activity.trackable.content : ': ' + activity.trackable.title
    end

    def recent_activity
        current_user.activities.order(created_at: :desc)[0, 10]
    end

end
