module EEML

  # An EEML environment object. Contains a number of EEML::Data objects amongst
  # other attributes.
  class Environment

    # Convert to EEML
    def to_eeml
      raise EEML::NoData.new('EEML requires at least one data item')
    end

  end

end