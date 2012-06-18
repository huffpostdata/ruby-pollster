module Pollster

  class Chart < Base

    attr_reader :title, :slug, :pollcount, :lastupdated, :url, :estimates, :state, :topic

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    # Get a list of polls for this chart.
    def polls
      Poll.by_chart(self.slug)
    end

    def self.all
      invoke('charts').map { |chart| self.create(chart) }
    end

    def self.find(slug)
      self.create invoke("charts/#{slug}")
    end

    def self.where(params={})
      if params.empty?
        raise "A search parameter is required"
      end
      invoke('charts', params).map { |chart| self.create(chart) }
    end

    def to_s
      "#{self.class}: #{self.title}"
    end

    def inspect
      "<#{self.class}: #{self.title}>"
    end

    private
      def self.create(data)
        data = Hash[*data.map { |k, v| [k.to_sym, v] }.flatten(1)]
        data[:estimates].map! { |estimate| {:choice => estimate['choice'], :value => estimate['value']} }
        self.new(data)
      end


  end

end
