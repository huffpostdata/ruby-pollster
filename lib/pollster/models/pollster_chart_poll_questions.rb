require 'ruby-immutable-struct'

module Pollster
  PollsterChartPollQuestion = RubyImmutableStruct.new(
    :responses,
    :poll_slug,
    :survey_house,
    :start_date,
    :end_date,
    :question_text,
    :sample_subpopulation,
    :observations,
    :margin_of_error,
    :mode,
    :partisanship,
    :partisan_affiliation
  ) do
    def self.from_tsv_line_with_labels(tsv_line, labels)
      if m = PollsterChartPollQuestion::TsvLineRegex.match(tsv_line)
        # split(..., -1) avoids omitting trailing blanks
        values = m[:values].split(/\t/, -1).map{ |v| v.empty? ? nil : v.to_f }

        if values.length != labels.length
          raise ArgumentError.new("TSV line `#{tsv_line}` has #{values.length} values for #{labels.length} labels")
        end

        responses = {}
        for i in 0...(labels.length)
          responses[labels[i]] = values[i]
        end

        PollsterChartPollQuestion.new(
          responses,
          m[:poll_slug],
          m[:survey_house],
          Date.parse(m[:start_date]),
          Date.parse(m[:end_date]),
          m[:question_text],
          m[:sample_subpopulation],
          m[:observations].empty? ? nil : m[:observations].to_i,
          m[:margin_of_error].empty? ? nil : m[:margin_of_error].to_f,
          m[:mode],
          m[:partisanship],
          m[:partisan_affiliation]
        )
      else
        raise ArgumentError.new("TSV line `#{tsv_line}` is not a valid PollsterChartPollQuestion line")
      end
    end
  end
  PollsterChartPollQuestion::TsvLineRegex = %r{
    \A
    (?<values>(?:\d+(?:\.\d+)?)?(?:\t(?:\d+(?:\.\d+)?)?)*)\t
    (?<poll_slug>[^\t]+)\t
    (?<survey_house>[^\t]+)\t
    (?<start_date>\d\d\d\d-\d\d-\d\d)\t
    (?<end_date>\d\d\d\d-\d\d-\d\d)\t
    (?<question_text>[^\t]*)\t
    (?<sample_subpopulation>[^\t]+)\t
    (?<observations>\d*)\t
    (?<margin_of_error>(?:\d+(?:\.\d+)?)?)\t
    (?<mode>[^\t]+)\t
    (?<partisanship>[^\t]+)\t
    (?<partisan_affiliation>[^\t]+)\b
    # No \Z ... Pollster's API doesn't guarantee it won't add columns
  }x

  class PollsterChartPollQuestions
    HeaderLineRegex = /\A(?<labels>[^\t]+(?:\t[^\t]+)*)\tpoll_slug\tsurvey_house\tstart_date\tend_date\tquestion_text\tsample_subpopulation\tobservations\tmargin_of_error\tmode\tpartisanship\tpartisan_affiliation\b/

    include Enumerable

    def initialize(array)
      @array = array
    end

    def each(&block)
      @array.each(&block)
    end

    def self.from_tsv(tsv)
      lines = tsv.split(/(?:\r?\n)+/).reject(&:empty?)
      if m = HeaderLineRegex.match(lines[0])
        labels = m[:labels].split(/\t/)
        rows = lines[1..-1].map { |tsv_line| PollsterChartPollQuestion.from_tsv_line_with_labels(tsv_line, labels) }
        PollsterChartPollQuestions.new(rows)
      else
        raise ArgumentError.new("First line of TSV is `#{lines[0]}`, which does not match Pollster::PollsterChartPollQuestions::HeaderLineRegex")
      end
    end
  end
end
