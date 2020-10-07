require 'rails_helper'
require './spec/support/login_helpers.rb'

RSpec.configure do |c|
    c.include LoginHelpers
end

RSpec.describe "users/new.html.erb", type: :view do
  pending "add some examples to (or delete) #{__FILE__}"
end
