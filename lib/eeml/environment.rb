module EEML

  class Environment

    def to_eeml
      raise EEML::NoData.new('EEML requires at least one data item')
    end

  end

end