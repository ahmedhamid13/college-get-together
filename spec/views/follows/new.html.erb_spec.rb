# frozen_string_literal: true

require "rails_helper"

RSpec.describe "follows/new", type: :view do
  before(:each) do
    assign(:follow, Follow.new(
                      followed: nil,
                      user: nil
    ))
  end

  it "renders new follow form" do
    render

    assert_select "form[action=?][method=?]", follows_path, "post" do
      assert_select "input[name=?]", "follow[followed_id]"

      assert_select "input[name=?]", "follow[user_id]"
    end
  end
end
