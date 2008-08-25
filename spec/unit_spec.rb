require File.dirname(__FILE__) + '/spec_helper.rb'

describe EEML::Unit do

  it "can be created with just a name" do
    lambda {
      EEML::Unit.new("Celsius")
    }.should_not raise_error
  end

  it "can be created with options" do
    lambda {
      EEML::Unit.new("Celsius", :symbol => 'C', :type => :derivedSI)
    }.should_not raise_error
  end

  it "cannot be created with invalid options" do
    lambda {
      EEML::Unit.new("Celsius", :symbol => 'C', :type => :cheese)
    }.should raise_error(ArgumentError, "Type must be one of :basicSI, :derivedSI, :conversionBasedUnits, :derivedUnits or :contextDependentUnits")
  end

  describe "with just a name" do

    before :each do
      @unit = EEML::Unit.new("Celsius")
    end
    
    it "should store name correctly" do
      @unit.name.should == "Celsius"
    end

    it "should allow symbol to be set" do
      @unit.symbol = "C"
      @unit.symbol.should == "C"
    end

    it "should allow type to be set to :basicSI" do
      @unit.type = :basicSI
      @unit.type.should == :basicSI
    end

    it "should allow type to be set to :derivedSI" do
      @unit.type = :derivedSI
      @unit.type.should == :derivedSI
    end

    it "should allow type to be set to :conversionBasedUnits" do
      @unit.type = :conversionBasedUnits
      @unit.type.should == :conversionBasedUnits
    end

    it "should allow type to be set to :derivedUnits" do
      @unit.type = :derivedUnits
      @unit.type.should == :derivedUnits
    end

    it "should allow type to be set to :contextDependentUnits" do
      @unit.type = :contextDependentUnits
      @unit.type.should == :contextDependentUnits
    end

    it "should not allow type to be set to anything other than allowed values" do
      lambda {
        @unit.type = :cheese
      }.should raise_error(ArgumentError, "Type must be one of :basicSI, :derivedSI, :conversionBasedUnits, :derivedUnits or :contextDependentUnits")
    end

  end
  
  describe "with options set on creation" do

    before :each do
      @unit = EEML::Unit.new("Celsius", :symbol => 'C', :type => :derivedSI)
    end
    
    it "should store symbol correctly" do
      @unit.symbol.should == "C"
    end

    it "should store type correctly" do
      @unit.type.should == :derivedSI
    end

  end

end
