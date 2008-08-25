module EEML

  # An class representing a unit or measurement. Can be added to EEML::Data
  # objects
  class Unit

    # Create a new EEML::Unit item.
    def initialize(unit_name, options = {})
      @name = unit_name
      @symbol = options[:symbol]
      set_type(options[:type])
    end

    # Name of the unit (e.g. "metre")
    attr_accessor :name

    # Symbol for the unit (e.g. "m")
    attr_accessor :symbol

    # Get the type of the unit
    def type
      @type
    end
    
    # Set the type of the unit - must be one of :basicSI, :derivedSI, :conversionBasedUnits, :derivedUnits or :contextDependentUnits
    def type=(unit_type)
      set_type(unit_type)
    end

  protected

    def set_type(unit_type)
      unless [nil, :basicSI, :derivedSI, :conversionBasedUnits, :derivedUnits, :contextDependentUnits].include?(unit_type)
        raise ArgumentError.new("Type must be one of :basicSI, :derivedSI, :conversionBasedUnits, :derivedUnits or :contextDependentUnits")
      end
      @type = unit_type
    end

  end

end