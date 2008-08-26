require 'rubygems'
require 'builder'
require 'rexml/document'
require 'time'

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

    # Convert to EEML. Optional parameter describes the version of EEML to generate.
    # Default (and currently only version implemented) is version 5.
    def to_eeml(version = nil)
      if version.nil? || version == 5
        # Check that we have some data items
        if size < 1
          raise EEML::NoData.new('EEML requires at least one data item')
        end
        # Create EEML
        eeml = Builder::XmlMarkup.new
        eeml.instruct!
        eeml_options = {:xmlns => "http://www.eeml.org/xsd/005",
                        :'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                        :'xsi:schemaLocation' => "http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd"}
        eeml_options[:version] = version if version
        eeml.eeml(eeml_options) do
          env_options = {}
          env_options[:updated] = @updated_at.xmlschema if @updated_at
          env_options[:creator] = @creator if @creator
          env_options[:id] = @id if @id
          eeml.environment(env_options) do |env|
            env.title @title if @title
            env.feed @feed if @feed
            env.status @status.to_s if @status
            env.description @description if @description
            env.icon @icon if @icon
            env.website @website if @website
            env.email @email if @email
            if @location
              loc_options = {}
              loc_options[:domain] = @location.domain
              loc_options[:exposure] = @location.exposure if @location.exposure
              loc_options[:disposition] = @location.disposition if @location.disposition
              env.location(loc_options) do |loc|
                loc.name @location.name if @location.name
                loc.lat @location.lat if @location.lat
                loc.lon @location.lon if @location.lon
                loc.ele @location.ele if @location.ele
              end
            end
            @data_items.each_index do |i|
              env.data(:id => i) do |data|
                @data_items[i].tags.each do |tag|
                  data.tag tag
                end
                value_options = {}
                value_options[:maxValue] = @data_items[i].max_value if @data_items[i].max_value
                value_options[:minValue] = @data_items[i].min_value if @data_items[i].min_value
                data.value @data_items[i].value, value_options
                if @data_items[i].unit
                  unit_options = {}
                  unit_options[:symbol] = @data_items[i].unit.symbol if @data_items[i].unit.symbol
                  unit_options[:type] = @data_items[i].unit.type if @data_items[i].unit.type
                  data.unit @data_items[i].unit.name, unit_options
                end
              end
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
      unless [nil, :frozen, :live].include?(val)
        raise ArgumentError.new("Status must be :frozen or :live") 
      end
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

    # The location of the feed
    attr_reader :location

    # Set the location of the feed - loc must be an EEML::Location object
    def location=(loc)
      unless loc.is_a?(EEML::Location)
        raise TypeError.new('loc must be an EEML::Location') 
      end
      @location = loc
    end

    # Last updated time
    attr_reader :updated_at

    # Set last updated time
    def updated_at=(time)
      unless time.is_a?(Time)
        raise TypeError.new('updated_at must be a Time object')
      end
      @updated_at = time
    end

    # Set last updated time
    def set_updated!
      @updated_at = Time.now
    end

    # A string showing the creator of this environment object
    attr_accessor :creator

    # The ID of the environment object
    attr_accessor :id

  end

end