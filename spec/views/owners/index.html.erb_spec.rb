require 'spec_helper'

describe "owners/index.html.erb" do
  before(:each) do
    assign(:owners, [
      stub_model(Owner,
        :name => "Name",
        :user_id => 1
      ),
      stub_model(Owner,
        :name => "Name",
        :user_id => 1
      )
    ])
  end

  it "renders a list of owners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
