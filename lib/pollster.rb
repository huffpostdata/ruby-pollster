# Common files
require 'pollster/api_client'
require 'pollster/api_error'
require 'pollster/version'
require 'pollster/configuration'

# Models
require 'pollster/models/chart'
require 'pollster/models/chart_estimate'
require 'pollster/models/chart_estimate_lowess_parameters'
require 'pollster/models/chart_pollster_estimate_summary'
require 'pollster/models/inline_response_200'
require 'pollster/models/chart_pollster_trendlines'
require 'pollster/models/pollster_chart_poll_questions'
require 'pollster/models/question_poll_responses_clean'
require 'pollster/models/question_poll_responses_raw'
require 'pollster/models/inline_response_200_3'
require 'pollster/models/inline_response_200_4'
require 'pollster/models/poll'
require 'pollster/models/poll_question'
require 'pollster/models/poll_question_responses'
require 'pollster/models/poll_question_sample_subpopulations'
require 'pollster/models/question'
require 'pollster/models/question_responses'
require 'pollster/models/tag'

# APIs
require 'pollster/api'

module Pollster
  class << self
    # Customize default settings for the SDK using block.
    #   Pollster.configure do |config|
    #     config.username = "xxx"
    #     config.password = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
