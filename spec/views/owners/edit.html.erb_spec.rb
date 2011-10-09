require 'spec_helper'

describe "owners/edit.html.erb" do
  before(:each) do
    @owner = assign(:owner, stub_model(Owner,
      :name => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit owner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => owners_path(@owner), :method => "post" do
      assert_select "input#owner_name", :name => "owner[name]"
      assert_select "input#owner_user_id", :name => "owner[user_id]"
    end
  end
end
