module Pollster

  class Chart < Base

    attr_reader :title, :slug, :poll_count, :last_updated, :url, :estimates, :estimates_by_date, :state, :topic

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    # Get a list of polls for this chart.
    def polls(params={})
      Poll.where(params.merge({:chart => self.slug}))
    end

    # Get a list of all charts.
    def self.all
      invoke('charts').map { |chart| self.create(chart) }
    end

    # Get a chart based on its slug.
    def self.find(slug)
      self.create invoke("charts/#{slug}")
    end

    # Get a list of charts based on the given parameters.
    # See API documentation for acceptable parameters.
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

    def estimates_by_date
      @estimates_by_date ||= Pollster::Chart.find(slug).estimates_by_date
    end

    private

      def self.create(data)
        data = Hash[*data.map { |k, v| [k.to_sym, v] }.flatten(1)]
        data[:last_updated] = Time.parse(data[:last_updated])
        data[:estimates].map! { |estimate| {:choice => estimate['choice'], :value => estimate['value']} }
        if data[:estimates_by_date]
          data[:estimates_by_date] = data[:estimates_by_date].map do |x|
            estimate = hash_keys_to_sym(x)
            estimate[:date] = Date.parse(estimate[:date])
            estimate[:estimates] = estimate[:estimates].map { |e| hash_keys_to_sym(e) }
            estimate
          end
        end
        self.new(data)
      end


  end

end
