module EEML

  # An EEML environment object. Can contain a number of EEML::Data objects, as
  # well as having other attributes.
  class Environment

    # Create new Environment object
    def initialize
      @data_items = []
    end

    # Convert to EEML
    def to_eeml
      raise EEML::NoData.new('EEML requires at least one data item')
    end

    # Add an EEML::Data object to the environment
    def <<(value)
      raise TypeError.new('Only EEML::Data objects can be added to EEML::Environment objects') unless value.is_a?(EEML::Data)
      @data_items << value
    end

    # The number of EEML::Data objets in the environment
    def size
      @data_items.size
    end

  end

end