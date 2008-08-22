require File.dirname(__FILE__) + '/spec_helper.rb'

describe EEML::Data do

  describe "with minimal information" do

    it "can be created with just a value" do
      lambda {
        env = EEML::Data.new(36.2)
      }.should_not raise_error
    end

    it "allows setting of the value" do
      env = EEML::Data.new(36.2)
      val = 42.7
      env.value = val
      env.value.should be(val)
    end

    it "provides access to value" do
      val = 36.2
      env = EEML::Data.new(val)
      env.value.should be(val)
    end

  end

end
