module Pollster

  class Poll < Base

    attr_reader :sdate, :edate, :mode, :pollster, :questions

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    def self.create(data)
      data = Hash[*data.map { |k, v| [k.to_sym, v] }.flatten(1)]
      self.new(data)
    end

    def self.by_chart(chart_slug)
      invoke('polls', {:chart => chart_slug}).map { |poll| self.create(poll) }
    end

  end

end
