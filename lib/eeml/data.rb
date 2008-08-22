module EEML

  # An EEML data item. A valid EEML::Environment must contain at least one of
  # these.
  class Data

    # Create a new EEML::Data item.
    def initialize(value)
      @value = value
    end

    # Data value
    attr_accessor :value

  end

end