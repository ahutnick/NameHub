require 'rails_helper'
require './spec/support/login_helpers.rb'
require 'webdrivers/chromedriver'

RSpec.configure do |c|
    c.include LoginHelpers
end

feature "Task Card Organization" do
    let (:task) { create(:task) }
    let (:task2) { create(:task, project: task.project, stage: "review") }

    scenario 'task card works' do
        @project = task.project
        log_in(@project.user)
        click_link(@project.title)
        @card_id = '#task-' + task.id.to_s
        expect(page).to have_css(@card_id, text: task.title)
    end

    scenario 'task card sorts', js: true do
        @project = task.project
        log_in(@project.user)
        click_link(@project.title)
        @path = find("#task-#{task.id.to_s}").path
        within("div##{task.stage}"){ find(:xpath, @path) }
    end

    scenario 'multiple task cards sort', js: true do
        @project = task2.project
        log_in(@project.user)
        click_link(@project.title)
        @path = find("#task-#{task.id.to_s}").path
        within("div##{task.stage}"){ find(:xpath, @path) }
        @path2 = find("#task-#{task2.id.to_s}").path
        within("div##{task2.stage}"){ find(:xpath, @path2) }
    end
end
