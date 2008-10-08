require File.dirname(__FILE__) + '/../spec_helper'

describe "error_messages_for" do

  before :each do
    @c = Application.new({})
    @dm_obj = Object.new
    @sq_obj = Object.new
    @dm_errors = [["foo", "bar"],["baz","bat"]]
    @sq_errors = Object.new
    @sq_errors.stub!(:full_messages).and_return(["foo", "baz"])
    @dm_obj.stub!(:errors).and_return(@dm_errors)
    @dm_obj.stub!(:new_record?).and_return(false)
    @sq_obj.stub!(:errors).and_return(@sq_errors)
    @sq_obj.stub!(:new_record?).and_return(false)
  end

  it "should build default error messages for AR-like models" do
    errs = @c.error_messages_for(@dm_obj)
    errs.should include("<h2>Form submission failed because of 2 problems</h2>")
    errs.should include("<li>foo bar</li>")
    errs.should include("<li>baz bat</li>")
  end

  it "should build default error messages for Sequel-like models" do
    errs = @c.error_messages_for(@sq_obj)
    errs.should include("<h2>Form submission failed because of 2 problems</h2>")
    errs.should include("<li>foo</li>")
    errs.should include("<li>baz</li>")
  end

  it "should build default error messages for symbol"

  it "should accept a custom HTML class" do
    errs = @c.error_messages_for(@dm_obj, :error_class => "foo")
    errs.should include("<div class='foo'>")
  end
  
  it "should accept a custom header block" do
    errs = @c.error_messages_for(@dm_obj, :header => "<h3>Failure: %s issue%s</h3>")
    errs.should include("<h3>Failure: 2 issues</h3>")
  end
end
