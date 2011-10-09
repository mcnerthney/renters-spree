require 'spec_helper'

describe "items/edit.html.erb" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :description => "MyString",
      :location => "MyString",
      :owner_id => 1
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path(@item), :method => "post" do
      assert_select "input#item_description", :name => "item[description]"
      assert_select "input#item_location", :name => "item[location]"
      assert_select "input#item_owner_id", :name => "item[owner_id]"
    end
  end
end
