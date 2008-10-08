require File.dirname(__FILE__) + '/../spec_helper'

describe "form_for" do
  before :each do
    @c = FormForSpecs.new(Merb::Request.new({}))
    @c.instance_variable_set(:@obj, FakeModel.new)
  end

  it "should wrap the contents in a form tag" do
    form = @c.render :basic
    form.should match_tag(:form, :method => "post")
    form.should match_tag(:input, :type => "hidden", :value => "put", :name => "_method")
  end

  it "should set the method to post be default" do
    new_fake_model = FakeModel2.new
    @c.instance_variable_set(:@obj, new_fake_model)
    form = @c.render :basic
    form.should match_tag(:form, :method => "post")
    form.should_not match_tag(:input, :type => "hidden", :name => "_method")
  end

  it "should support PUT if the object passed in is not a new_record? via a hidden field" do
    form = @c.render :basic
    form.should match_tag(:form, :method => "post")
    form.should match_tag(:input, :type => "hidden", :value => "put", :name => "_method")
  end
end
