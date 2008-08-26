require File.dirname(__FILE__) + '/spec_helper.rb'

describe EEML::Location do

  it "can be created with just a domain" do
    lambda {
      EEML::Location.new(:physical)
    }.should_not raise_error
  end

  it "cannot be created with an invalid domain" do
    lambda {
      EEML::Location.new(nil)
    }.should raise_error(ArgumentError, "Domain must be :physical or :virtual")
  end

  it "can be created with extra options" do
    loc = EEML::Location.new(:physical,
                             :exposure => :indoor,
                             :disposition => :fixed,
                             :name => "My Room",
                             :lat => 32.4,
                             :lon => 22.7,
                             :ele => 0.2)
    loc.exposure.should == :indoor
    loc.disposition.should == :fixed
    loc.name.should == "My Room"
    loc.lat.should == 32.4
    loc.lon.should == 22.7
    loc.ele.should == 0.2
  end
  
  describe "with minimal information" do

    before :each do
      @loc = EEML::Location.new(:physical)
    end
    
    it "allows domain to be set to :physical" do
      @loc.domain = :physical
      @loc.domain.should == :physical
    end

    it "allows domain to be set to :virtual" do
      @loc.domain = :virtual
      @loc.domain.should == :virtual
    end

    it "does not allow invalid domain settings" do
      lambda {
        @loc.domain = :cheese
      }.should raise_error(ArgumentError, "Domain must be :physical or :virtual")
    end

    it "allows exposure to be set to :indoor" do
      @loc.exposure = :indoor
      @loc.exposure.should == :indoor
    end

    it "allows exposure to be set to :outdoor" do
      @loc.exposure = :outdoor
      @loc.exposure.should == :outdoor
    end

    it "does not allow invalid exposure settings" do
      lambda {
        @loc.exposure = :cheese
      }.should raise_error(ArgumentError, "Exposure must be :indoor or :outdoor")
    end

    it "allows disposition to be set to :fixed" do
      @loc.disposition = :fixed
      @loc.disposition.should == :fixed
    end

    it "allows disposition to be set to :mobile" do
      @loc.disposition = :mobile
      @loc.disposition.should == :mobile
    end

    it "does not allow invalid disposition settings" do
      lambda {
        @loc.disposition = :cheese
      }.should raise_error(ArgumentError, "Disposition must be :fixed or :mobile")
    end

    it "can have a name" do
      name = "My Room"
      @loc.name = name
      @loc.name.should == name
    end

    it "can have a latitude" do
      lat = 32.4
      @loc.lat = lat
      @loc.lat.should == lat
    end

    it "cannot have a latitude outside -90..90" do
      lat = 90.1
      lambda {
        @loc.lat = lat
      }.should raise_error(ArgumentError, "Latitude must be between -90 and +90")
      lat = -90.1
      lambda {
        @loc.lat = lat
      }.should raise_error(ArgumentError, "Latitude must be between -90 and +90")
    end

    it "can have a longitude" do
      lon = 22.7
      @loc.lon = lon
      @loc.lon.should == lon
    end

    it "cannot have a longitude outside -180..180" do
      lon = 180.1
      lambda {
        @loc.lon = lon
      }.should raise_error(ArgumentError, "Longitude must be between -180 and +180")
      lon = -180.1
      lambda {
        @loc.lon = lon
      }.should raise_error(ArgumentError, "Longitude must be between -180 and +180")
    end

    it "can have an elevation" do
      ele = 0.2
      @loc.ele = ele
      @loc.ele.should == ele
    end

  end


end
