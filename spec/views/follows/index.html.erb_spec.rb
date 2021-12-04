# frozen_string_literal: true

require "rails_helper"

RSpec.describe "follows/index", type: :view do
  before(:each) do
    assign(:follows, [
      Follow.create!(
        followed: nil,
        user: nil
      ),
      Follow.create!(
        followed: nil,
        user: nil
      )
    ])
  end

  it "renders a list of follows" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
