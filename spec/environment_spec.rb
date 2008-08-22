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

  describe "with a single data item" do
    
    before(:each) do
      @env = EEML::Environment.new
      @data = EEML::Data.new(36.2)
      @env << @data
    end

    it "generates the 'minimal' EEML example document" do
      @env.to_eeml.should == '<?xml version="1.0" encoding="UTF-8"?><eeml xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.eeml.org/xsd/005" xsi:schemaLocation="http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd"><environment><data id="0"><value>36.2</value></data></environment></eeml>'
    end

    it "should allow access to the data item" do
      @env[0].should be(@data)
    end

  end
  
  describe "being created from XML" do
    
    it "parses the 'minimal' EEML example document" do
      eeml = '<?xml version="1.0" encoding="UTF-8"?><eeml xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.eeml.org/xsd/005" xsi:schemaLocation="http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd"><environment><data id="0"><value>36.2</value></data></environment></eeml>'
      env = EEML::Environment.from_eeml(eeml)
      env.size.should be(1)
      env[0].value.should be_close(36.2, 1e-9)
    end

  end

end
