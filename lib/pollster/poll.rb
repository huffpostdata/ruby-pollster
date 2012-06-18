module Pollster

  class Poll < Base

    attr_reader :start_date, :end_date, :mode, :pollster, :questions

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    # Get a list of all polls.
    # Polls are listed in pages of 25.
    def self.all(page=1)
      invoke('polls', {:page => page}).map { |poll| self.create(poll) }
    end

    # Get a list of polls for a chart.
    def self.by_chart(chart_slug)
      invoke('polls', {:chart => chart_slug}).map { |poll| self.create(poll) }
    end

    private

      def self.create(data)
        data = Hash[*data.map { |k, v| [k.to_sym, v] }.flatten(1)]
        data[:start_date] = Date.parse(data[:sdate])
        data[:end_date] = Date.parse(data[:edate])
        self.new(data)
      end


  end

end
