module Pollster

  class Poll < Base

    attr_reader :start_date, :end_date, :method, :pollster, :url, :source, :questions, :survey_houses, :sponsors

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    # Get a list of all polls.
    # Polls are listed in pages of 10.
    def self.all(params={})
      page = params[:page] || 1
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

      def self.create(data)
        data = hash_keys_to_sym(data)
        data[:questions] = data[:questions].map { |question| hash_keys_to_sym(question) }
        data[:questions].each { |question| question[:subpopulations] = question[:subpopulations].map { |subpopulation| hash_keys_to_sym(subpopulation) } }
        data[:questions].each { |question| question[:subpopulations].each { |subpopulation| subpopulation[:responses] = subpopulation[:responses].map { |response| hash_keys_to_sym(response) } } }
        data[:questions] = data[:questions].map { |question| Pollster::Question.new(question) }
        data[:start_date] = Date.parse(data[:start_date])
        data[:end_date] = Date.parse(data[:end_date])
        data[:survey_houses] = data[:survey_houses].map { |survey_house| hash_keys_to_sym(survey_house) }
        data[:sponsors] = data[:sponsors].map { |sponsor| hash_keys_to_sym(sponsor) }
        self.new(data)
      end


  end

end
