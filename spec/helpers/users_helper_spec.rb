require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let (:project) { create(:project) }

  describe 'form_field_exists?' do
    it "returns value or '' if nil " do
      expect(helper.form_field_exists?(project.user.email)).to eq(project.user.email)
      project.description = nil
      project.save
      expect(helper.form_field_exists?(project.description)).to eq("")
    end
  end
end
