module TasksHelper
    def completed
        Task.where(stage: "completed").count
    end

    def total
        Task.count
    end
end
