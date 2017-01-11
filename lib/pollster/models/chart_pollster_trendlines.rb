require 'date'
require 'ruby-immutable-struct'

module Pollster
  ChartPollsterTrendlinePoint = RubyImmutableStruct.new(:label, :date, :value, :low, :high) do
    def self.from_tsv_line(tsv_line)
      if m = ChartPollsterTrendlinePoint::TsvLineRegex.match(tsv_line)
        ChartPollsterTrendlinePoint.new(
          m[:label],
          Date.parse(m[:date]),
          m[:value].to_f,
          m[:low].empty? ? nil : m[:low].to_f,
          m[:high].empty? ? nil : m[:high].to_f
        )
      else
        raise ArgumentError.new("TSV line `#{tsv_line}` is not a valid ChartPollsterTrendlinePoint line")
      end
    end
  end
  ChartPollsterTrendlinePoint::TsvLineRegex = /\A(?<label>[^\t]+)\t(?<date>\d\d\d\d-\d\d-\d\d)\t(?<value>\d+(?:\.\d+)?)\t(?<low>(?:\d+(?:\.\d+)?)?)\t(?<high>(?:\d+(?:\.\d+)?)?)/

  ChartPollsterTrendlines = RubyImmutableStruct.new(:points) do
    ExpectedHeaderLine = "label\tdate\tvalue\tlow\thigh"

    def by_label
      ret = points.group_by(&:label)
      ret.values.each { |arr| arr.sort_by!(&:date) }
      ret
    end

    def self.from_tsv(tsv)
      lines = tsv.split(/(?:\r?\n)+/).reject(&:empty?)
      if /\A#{ExpectedHeaderLine}/ !~ lines[0]
        raise ArgumentError.new("First line of TSV is `#{lines[0]}`; expected `#{ExpectedHeaderLine}`")
      else
        points = lines[1..-1].map { |tsv_line| ChartPollsterTrendlinePoint.from_tsv_line(tsv_line) }
        ChartPollsterTrendlines.new(points)
      end
    end
  end
end
