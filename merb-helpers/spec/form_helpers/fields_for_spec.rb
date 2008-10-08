require File.dirname(__FILE__) + '/../spec_helper'

describe "fields_for" do  

  before :each do
    @c = FieldsForSpecs.new(Merb::Request.new({}))
    @c.instance_variable_set(:@obj, FakeModel.new)
  end


  it "should dump the contents in the context of the object" do
    r = @c.render :basic
    r.should match_tag(:input, :type => "text", :value => "foowee")
  end

  it "should be able to modify the context midstream" do
    @c.instance_variable_set(:@obj2, FakeModel2.new)
    r = @c.render :midstream
    r.should match_tag(:input, :type => "text", :value => "foowee")
    r.should match_tag(:input, :name => "fake_model2[foo]", :type => "text", :value => "foowee2")
  end

  it "should handle an explicit nil attribute" do
    r = @c.render :nil
    r.should match_tag(:input, :name => "fake_model[foo]", :value => "foowee", :type => "text")
  end

  it "should pass context back to the old object after exiting block" do
    @c.instance_variable_set(:@obj2, FakeModel2.new)
    r = @c.render :midstream
    r.should match_tag(:input, :id => "fake_model_foo", :name => "fake_model[foo]", :type => "text", :extra => "true")
  end
end
