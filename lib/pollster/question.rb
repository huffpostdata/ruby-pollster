module Pollster

  class Question < Base

    attr_reader :name, :chart, :topic, :state, :subpopulations

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    def responses
      subpopulations.first[:responses]
    end

  end

end
