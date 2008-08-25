require 'rubygems'
require 'builder'
require 'rexml/document'

module EEML

  # An EEML environment object. Can contain a number of EEML::Data objects, as
  # well as having other attributes.
  class Environment

    # Create new Environment object
    def initialize
      @data_items = []
    end

    # Create from an EEML document
    def self.from_eeml(eeml)
      # Parse EEML
      doc = REXML::Document.new(eeml)
      # Create environment object
      env = Environment.new
      # Read data items
      REXML::XPath.each(doc, "/eeml/environment/data") do |node|
        env << EEML::Data.new(node.elements['value'].text.to_f)
      end
      # Done
      return env
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

    # The title for this EEML feed
    attr_accessor :title

    # The URL for this EEML feed
    attr_accessor :feed

    # The status of this EEML feed - can be :frozen or :live
    def status
      @status
    end
    # The status of this EEML feed - can be :frozen or :live
    def status=(val)
      raise ArgumentError.new("Status must be :frozen or :live") unless [:frozen, :live].include?(val)
      @status = val
    end

    # A description of this EEML feed
    attr_accessor :description

    # The URL of an icon for this feed
    attr_accessor :icon
    
    # The URL of a website related to this feed
    attr_accessor :website

    # The email address of the feed creator
    attr_accessor :email

  end

end