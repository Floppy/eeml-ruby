module EEML

  # An EEML data item. A valid EEML::Environment must contain at least one of
  # these.
  class Data

    # Create a new EEML::Data item.
    def initialize(value)
      @value = value
      @tags = []
    end

    # Data value
    attr_accessor :value

    # Tag array
    attr_accessor :tags

    # Minimum value
    attr_accessor :min_value

    # Maximum value
    attr_accessor :max_value

    # Unit of measurement
    def unit
      @unit
    end

    # Unit of measurement - must be a EEML::Unit object
    def unit=(unit_val)
      unless unit_val.is_a?(EEML::Unit)
        raise TypeError.new("unit must be an EEML::Unit") 
      end
      @unit = unit_val
    end

  end

end