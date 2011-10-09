require 'spec_helper'

describe "items/new.html.erb" do
  before(:each) do
    assign(:item, stub_model(Item,
      :description => "MyString",
      :location => "MyString",
      :owner_id => 1
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_description", :name => "item[description]"
      assert_select "input#item_location", :name => "item[location]"
      assert_select "input#item_owner_id", :name => "item[owner_id]"
    end
  end
end
