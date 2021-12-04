# frozen_string_literal: true

require "rails_helper"

RSpec.describe "likes/new", type: :view do
  before(:each) do
    assign(:like, Like.new(
                    is_like: false,
                    user: nil,
                    post: nil
    ))
  end

  it "renders new like form" do
    render

    assert_select "form[action=?][method=?]", likes_path, "post" do
      assert_select "input[name=?]", "like[is_like]"

      assert_select "input[name=?]", "like[user_id]"

      assert_select "input[name=?]", "like[post_id]"
    end
  end
end
