#!/usr/bin/env ruby

require 'pollster'

api = Pollster::Api.new

# GET /tags
puts "GET /tags..."

tags = api.tags_get()

puts "  Found #{tags.count} tags"
puts "  First tag: #{tags.first.slug} (#{tags.first.n_charts} charts)"

# GET /charts
puts "GET /charts..."

charts = api.charts_get({
  cursor: nil,                            # String | Special string to index into the Array
  tags: "2016-president",                 # String | Comma-separated list of tag slugs
  election_date: Date.parse("2016-11-08") # Date | Date of an election
})

puts "  Found #{charts.count} charts; our reults page has #{charts.items.length} charts"

# GET /charts/:slug
puts "GET /charts/:slug..."
chart_slug = charts.items.first.slug
puts "  First chart has slug `#{chart_slug}`"

chart = api.charts_slug_get(chart_slug)

puts "  Found chart `#{chart.slug}`"
puts "  Tags: #{chart.tags.join(', ')}"
puts "  Question: #{chart.question.slug}"
puts "  Polls that answer Question: #{chart.question.n_polls}"

# GET /polls, and pagination
puts "GET /polls..."
# Pick a question that has enough polls that we'll need to paginate
question_slug = charts.items.find{ |c| c.question.n_polls > 30 }.question.slug

polls = api.polls_get({
  cursor: nil,
  question: question_slug,
  tags: nil,
  sort: 'created_at'
})

puts "  Found #{polls.count} polls; our results page has #{polls.items.count} polls and begins with #{polls.items.first.slug}"
puts "  next_cursor is #{polls.next_cursor}; using it in another GET request...."

polls2 = api.polls_get({
  cursor: polls.next_cursor,
  question: question_slug,
  tags: nil,
  sort: 'created_at'
})

puts "  Got another #{polls2.items.count} polls, such as #{polls2.items.first.slug}"

# GET /polls/:slug -- unnecessary here, since a Poll's data shows up in GET /polls
puts "GET /polls/:slug..."
poll_slug = polls.items.first.slug
puts "  First poll has slug `#{poll_slug}`"

poll = api.polls_slug_get(poll_slug)

puts "  Found poll `#{poll.slug}`"
puts "  Poll conducted from: #{poll.start_date} to: #{poll.end_date}, entered into Pollster: #{poll.created_at}"
puts "  Questions: #{poll.poll_questions.length}"
puts "  First question name: #{poll.poll_questions[0].question.name}"
puts "  First question options: #{poll.poll_questions[0].question.responses.map(&:label).join(', ')}"
puts "  First question first sample subpopulation: #{poll.poll_questions[0].sample_subpopulations[0].name}"
puts "  First question responses: #{poll.poll_questions[0].sample_subpopulations[0].responses.map { |r| "#{r.text} (#{r.pollster_label}): #{r.value}" }.join('; ')}"

# GET /charts/:slug/pollster-trendlines.tsv
puts "GET /charts/:slug/pollster-trendlines.tsv..."

trendlines = api.charts_slug_pollster_trendlines_tsv_get(chart_slug)

puts "  Found #{trendlines.points.length} trendline points"
first_label = chart.question.responses[0].label
first_trendline = trendlines.by_label[first_label]
puts "  Trendline for #{first_label} has #{first_trendline.length} points"
puts "  Most recent points: #{first_trendline.last(5).map{ |p| "#{p.date.to_s}:#{p.value}" }.join(', ')}"

# GET /charts/:slug/pollster-chart-poll-questions.tsv
puts "GET /charts/:slug/pollster-chart-poll-questions.tsv..."

chart_poll_questions = api.charts_slug_pollster_chart_poll_questions_tsv_get(chart_slug)

puts "  Found #{chart_poll_questions.count} poll questions plotted on chart"
puts "  Most recent poll: #{chart_poll_questions.first.poll_slug} (#{chart_poll_questions.first.start_date.to_s} to #{chart_poll_questions.first.end_date.to_s})"
puts "  Responses (as plotted on the chart): #{chart_poll_questions.first.responses.map{ |k, v| "#{k} #{v}" }.join(', ')}"

# GET /questions
puts "GET /questions..."

questions = api.questions_get({
  cursor: nil,                            # String | Special string to index into the Array
  tags: "2016-president",                 # String | Comma-separated list of tag slugs (most Questions are not tagged)
  election_date: Date.parse("2016-11-08") # Date | Date of an election
})

puts "  Found #{questions.count} Questions matching request"
puts "  First Question: #{questions.items.first.slug} (#{questions.items.first.name})"
puts "  Responses Pollster tracks: #{questions.items.first.responses.map(&:label).join(", ")}"

# GET /question/:slug/poll_responses_clean.tsv
puts "GET /question/:slug/poll_responses_clean.tsv..."

responses_clean = api.questions_slug_poll_responses_clean_tsv_get(question_slug)

puts "  Found #{responses_clean.count} responses to Question #{question_slug}"
puts "  Most recent poll: #{responses_clean.first.poll_slug} (#{responses_clean.first.start_date.to_s} to #{responses_clean.first.end_date.to_s})"
puts "  Responses (as aggregated by Pollster): #{responses_clean.first.responses.map{ |k, v| "#{k} #{v}" }.join(', ')}"

# GET /question/:slug/poll_responses_raw.tsv
puts "GET /question/:slug/poll_responses_raw.tsv..."

responses_raw = api.questions_slug_poll_responses_raw_tsv_get(question_slug)

puts "  Found #{responses_raw.count} response data points to Question #{question_slug}"
puts "  Most recent for label #{first_label}:"
for r in responses_raw.select{ |r| r.pollster_label == first_label }.first(5)
  puts "    #{r.poll_slug} on #{r.end_date.to_s}, prompting #{r.sample_subpopulation} for #{r.response_text}: #{r.value}"
end
