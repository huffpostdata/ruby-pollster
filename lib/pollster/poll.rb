module Pollster

  class Poll < Base

    attr_reader :start_date, :end_date, :method, :pollster, :url, :source, :questions

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

    # Get a list of polls based on the given parameters.
    # See API documentation for acceptable parameters.
    def self.where(params={})
      if params.empty?
        raise "A search parameter is required"
      end
      invoke('polls', params).map { |poll| self.create(poll) }
    end

    private

      def self.hash_keys_to_sym(hash)
        Hash[*hash.map { |k, v| [k.to_sym, v] }.flatten(1)]
      end

      def self.create(data)
        data = self.hash_keys_to_sym(data)
        data[:questions] = data[:questions].map { |question| self.hash_keys_to_sym(question) }
        data[:questions].each { |question| question[:responses] = question[:responses].map { |response| hash_keys_to_sym(response) } }
        data[:start_date] = Date.parse(data[:start_date])
        data[:end_date] = Date.parse(data[:end_date])
        self.new(data)
      end


  end

end
