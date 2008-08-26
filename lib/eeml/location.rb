module EEML

  # An class representing a location. Can be added to EEML::Data objects.
  class Location

    # Create a new EEML::Location item. Domain setting is required, and must be either :physical or :virtual.
    def initialize(loc_domain, options = {})
      set_domain(loc_domain)
      set_exposure(options[:exposure])
      set_disposition(options[:disposition])
      @name = options[:name]
      self.lat = options[:lat]
      self.lon = options[:lon]
      @ele = options[:ele]
    end

    # Domain (:physical or :virtual)
    attr_reader :domain
    
    # Set the domain of the Location - must be either :physical or :virtual
    def domain=(loc_domain)
      set_domain(loc_domain)
    end

    # Exposure (:indoor or :outdoor)
    attr_reader :exposure
    
    # Set the exposure of the Location - must be either :indoor or :outdoor
    def exposure=(loc_exposure)
      set_exposure(loc_exposure)
    end

    # Disposition (:fixed or :mobile)
    attr_reader :disposition
    
    # Set the disposition of the Location - must be either :fixed or :mobile
    def disposition=(loc_disposition)
      set_disposition(loc_disposition)
    end

    # The name of the location
    attr_accessor :name

    # Latitude of location
    attr_reader :lat
    
    # Set the latitude of the location
    def lat=(latitude)
      if latitude && (latitude < -90 || latitude > 90)
        raise ArgumentError.new("Latitude must be between -90 and +90") 
      end
      @lat = latitude
    end
    
    # Longitude of location
    attr_reader :lon
    
    # Set the longitude of the location
    def lon=(longitude)      
      if longitude && (longitude < -180 || longitude > 180)
        raise ArgumentError.new("Longitude must be between -180 and +180") 
      end
      @lon = longitude
    end

    # Elevation of location
    attr_accessor :ele
    
    protected

    def set_domain(loc_domain)
      unless [:physical, :virtual].include?(loc_domain)
        raise ArgumentError.new("Domain must be :physical or :virtual")
      end
      @domain = loc_domain
    end

    def set_exposure(loc_exposure)
      unless [nil, :indoor, :outdoor].include?(loc_exposure)
        raise ArgumentError.new("Exposure must be :indoor or :outdoor")
      end
      @exposure = loc_exposure
    end

    def set_disposition(loc_disposition)
      unless [nil, :fixed, :mobile].include?(loc_disposition)
        raise ArgumentError.new("Disposition must be :fixed or :mobile")
      end
      @disposition = loc_disposition
    end

  end

end