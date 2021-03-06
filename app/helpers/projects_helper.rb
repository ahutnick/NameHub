module ProjectsHelper
    def progress
        "#{completed} / #{total} ( #{percent}% )"
    end

    def percent
        ((completed / total.to_f) * 100).floor
    end

    def completed?
        percent == 100
    end
end
