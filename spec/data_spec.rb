require File.dirname(__FILE__) + '/spec_helper.rb'

describe EEML::Data do

  describe "with minimal information" do

    it "can be created with just a value" do
      lambda {
        data = EEML::Data.new(36.2)
      }.should_not raise_error
    end

    it "allows setting of the value" do
      data = EEML::Data.new(36.2)
      val = 42.7
      data.value = val
      data.value.should be(val)
    end

    it "provides access to value" do
      val = 36.2
      data = EEML::Data.new(val)
      data.value.should be(val)
    end

  end

  describe "after creation" do
    
    before :each do
      @data = EEML::Data.new(42)
    end
    
    it "can be tagged" do
      @data.tags.is_a?(Array).should be_true
      @data.tags.should be_empty
      @data.tags << "test1"
      @data.tags << "test2"
      @data.tags.size.should be(2)
      @data.tags[0].should == "test1"
      @data.tags[1].should == "test2"
    end

    it "can have a minimum value" do
      val = 10
      @data.min_value = val
      @data.min_value.should == val
    end

    it "can have a maximum value" do
      val = 100
      @data.max_value = val
      @data.max_value.should == val
    end

  end
  
end
