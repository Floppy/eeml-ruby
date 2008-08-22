require 'builder'

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
      # Check that we have some data items
      raise EEML::NoData.new('EEML requires at least one data item') if size < 1
      # Create EEML
      eeml = Builder::XmlMarkup.new
      eeml.instruct!
      eeml.eeml(:xmlns => "http://www.eeml.org/xsd/005",
                :'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                :'xsi:schemaLocation' => "http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd") do
        eeml.environment do
          @data_items.each_index do |i|
            eeml.data(:id => i) do
              eeml.value @data_items[i].value
            end
          end
        end
      end
    end

    # Add an EEML::Data object to the environment
    def <<(value)
      raise TypeError.new('Only EEML::Data objects can be added to EEML::Environment objects') unless value.is_a?(EEML::Data)
      @data_items << value
    end

    # The number of EEML::Data objects in the environment
    def size
      @data_items.size
    end

    # Access contained EEML::Data objects
    def [](index)
      @data_items[index]
    end

  end

end