# frozen_string_literal: true

require "rails_helper"

RSpec.describe "follows/edit", type: :view do
  before(:each) do
    @follow = assign(:follow, Follow.create!(
                                followed: nil,
                                user: nil
    ))
  end

  it "renders the edit follow form" do
    render

    assert_select "form[action=?][method=?]", follow_path(@follow), "post" do
      assert_select "input[name=?]", "follow[followed_id]"

      assert_select "input[name=?]", "follow[user_id]"
    end
  end
end
