require 'spec_helper'

describe "stores/edit.html.erb" do
  before(:each) do
    @store = assign(:store, stub_model(Store,
      :name => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stores_path(@store), :method => "post" do
      assert_select "input#store_name", :name => "store[name]"
      assert_select "input#store_user_id", :name => "store[user_id]"
    end
  end
end
