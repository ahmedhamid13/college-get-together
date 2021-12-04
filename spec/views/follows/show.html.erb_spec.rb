# frozen_string_literal: true

require "rails_helper"

RSpec.describe "follows/show", type: :view do
  before(:each) do
    @follow = assign(:follow, Follow.create!(
                                followed: nil,
                                user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
