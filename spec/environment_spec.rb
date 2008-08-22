require File.dirname(__FILE__) + '/spec_helper.rb'

describe EEML::Environment do

  describe "without any data" do

    it "can be created" do
      lambda {
        env = EEML::Environment.new
      }.should_not raise_error
    end

    it "raises an error when converted to EEML" do
      env = EEML::Environment.new
      lambda {
        env.to_eeml
      }.should raise_error(EEML::NoData, "EEML requires at least one data item")
    end

  end

  describe "after creation" do
    
    before(:each) do
      @env = EEML::Environment.new
    end

    it "can have a data item added to it" do
      lambda {
        @env << EEML::Data.new(36.2)
      }.should_not raise_error
      @env.size.should be(1)
    end

    it "can only have EEML::Data items added to it" do
      lambda {
        @env << 36.2
      }.should raise_error(TypeError, "Only EEML::Data objects can be added to EEML::Environment objects")
      @env.size.should be(0)
    end
    
  end

end
