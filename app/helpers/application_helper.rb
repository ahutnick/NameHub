module ApplicationHelper
    def date_format(date)
        date.strftime("%m-%e-%Y, %l:%M %p")
    end
end
