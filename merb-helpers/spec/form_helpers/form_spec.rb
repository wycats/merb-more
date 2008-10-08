require File.dirname(__FILE__) + '/../spec_helper'

describe "form" do

  before :each do
    @c = FormSpecs.new(Merb::Request.new({}))
  end

  describe "when _default_builder is Merb::Helpers::Form::Builder::ResourcefulFormWithErrors" do

    before(:each) do
      @obj = FakeModel2.new
      @c.instance_variable_set(:@obj, @obj)
    end

    it "should not explode when #form is called" do
      r = @c.render :resourceful_form
      pending
      #r.should =~ /action="fake_model2\/#{@obj.id}"/
    end
  end


  it "should use the post method by default" do
    ret = @c.render(:post_by_default)
    ret.should match_tag(:form, :method => "post")
    ret.should include("CONTENT")
  end

  it "should use the get method if set" do
    ret = @c.render(:get_if_set)
    ret.should match_tag(:form, :method => "get")
  end
  
  it "should fake out the put method if set" do
    ret = @c.render(:fake_put_if_set)
    ret.should match_tag(:form, :method => "post")
    ret.should match_tag(:input, :type => "hidden", :name => "_method", :value => "put")
  end
  
  it "should fake out the delete method if set" do
    ret = @c.render(:fake_delete_if_set)
    ret.should match_tag(:form, :method => "post")
    ret.should match_tag(:input, :type => "hidden", :name => "_method", :value => "delete")
  end
  
  # TODO: Why is this required?
  # ---------------------------
  # 
  # it "should silently set method to post if an unsupported method is used" do
  #     form_tag :method => :dodgy do
  #       _buffer << "CONTENT"
  #     end
  #     _buffer.should match_tag(:form, :method => "post")
  #     _buffer.should_not match_tag(:input, :type => "hidden", :name => "_method", :value => "dodgy")
  # end
  
  it "should take create a form" do
    ret = @c.render(:create_a_form)  
    ret.should match_tag(:form, :action => "foo", :method => "post")
    ret.should include("Hello")
  end
  
  it "should set a form to be multipart" do
    ret = @c.render(:create_a_multipart_form)
    ret.should match_tag( :form, :action => "foo", :method => "post", :enctype => "multipart/form-data")
    ret.should include("CONTENT")
  end
end
