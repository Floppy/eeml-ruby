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

end
