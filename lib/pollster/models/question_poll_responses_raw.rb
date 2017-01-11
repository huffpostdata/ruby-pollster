require 'date'
require 'ruby-immutable-struct'

module Pollster
  QuestionPollResponseRaw = RubyImmutableStruct.new(
    :response_text,
    :pollster_label,
    :value,
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
    def self.from_tsv_line(tsv_line)
      if m = QuestionPollResponseRaw::TsvLineRegex.match(tsv_line)
        QuestionPollResponseRaw.new(
          m[:response_text],
          m[:pollster_label],
          m[:value].to_f,
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
        raise ArgumentError.new("TSV line `#{tsv_line}` is not a valid QuestionPollResponseRaw line")
      end
    end
  end
  QuestionPollResponseRaw::TsvLineRegex = %r{
    \A
    (?<response_text>[^\t]+)\t
    (?<pollster_label>[^\t]*)\t
    (?<value>\d+(?:\.\d+)?)\t
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

  class QuestionPollResponsesRaw
    HeaderLineRegex = /\Aresponse_text\tpollster_label\tvalue\tpoll_slug\tsurvey_house\tstart_date\tend_date\tquestion_text\tsample_subpopulation\tobservations\tmargin_of_error\tmode\tpartisanship\tpartisan_affiliation\b/

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
        rows = lines[1..-1].map { |tsv_line| QuestionPollResponseRaw.from_tsv_line(tsv_line) }
        QuestionPollResponsesRaw.new(rows)
      else
        raise ArgumentError.new("First line of TSV is `#{lines[0]}`, which does not match Pollster::QuestionPollResponsesRaw::HeaderLineRegex")
      end
    end
  end
end
