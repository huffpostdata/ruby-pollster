require "uri"

module Pollster
  class Api
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    # Charts
    # Returns a list of Charts, ordered by creation date (newest first).  A Chart is chosen by Pollster editors. One example is \"Obama job approval - Democrats\". It is always based upon a single Question.  Users should strongly consider basing their analysis on Questions instead. Charts are derived data; Pollster editors publish them and change them as editorial priorities change. 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Special string to index into the Array
    # @option opts [String] :tags Comma-separated list of tag slugs. Only Charts with one or more of these tags and Charts based on Questions with one or more of these tags will be returned.
    # @option opts [Date] :election_date Date of an election, in YYYY-MM-DD format. Only Charts based on Questions pertaining to an election on this date will be returned.
    # @return [InlineResponse200]
    def charts_get(opts = {})
      data, _status_code, _headers = charts_get_with_http_info(opts)
      return data
    end

    # Charts
    # Returns a list of Charts, ordered by creation date (newest first).  A Chart is chosen by Pollster editors. One example is \&quot;Obama job approval - Democrats\&quot;. It is always based upon a single Question.  Users should strongly consider basing their analysis on Questions instead. Charts are derived data; Pollster editors publish them and change them as editorial priorities change. 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Special string to index into the Array
    # @option opts [String] :tags Comma-separated list of tag slugs. Only Charts with one or more of these tags and Charts based on Questions with one or more of these tags will be returned.
    # @option opts [Date] :election_date Date of an election, in YYYY-MM-DD format. Only Charts based on Questions pertaining to an election on this date will be returned.
    # @return [Array<(InlineResponse200, Fixnum, Hash)>] InlineResponse200 data, response status code and response headers
    def charts_get_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.charts_get ..."
      end
      # resource path
      local_var_path = "/charts".sub('{format}','json')

      # query parameters
      query_params = {}
      query_params[:'cursor'] = opts[:'cursor'] if !opts[:'cursor'].nil?
      query_params[:'tags'] = opts[:'tags'] if !opts[:'tags'].nil?
      query_params[:'election_date'] = opts[:'election_date'] if !opts[:'election_date'].nil?

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse200')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#charts_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Chart
    # A Chart is chosen by Pollster editors. One example is \"Obama job approval - Democrats\". It is always based upon a single Question.  Users should strongly consider basing their analysis on Questions instead. Charts are derived data; Pollster editors publish them and change them as editorial priorities change. 
    # @param slug Unique identifier for a Chart
    # @param [Hash] opts the optional parameters
    # @return [Chart]
    def charts_slug_get(slug, opts = {})
      data, _status_code, _headers = charts_slug_get_with_http_info(slug, opts)
      return data
    end

    # Chart
    # A Chart is chosen by Pollster editors. One example is \&quot;Obama job approval - Democrats\&quot;. It is always based upon a single Question.  Users should strongly consider basing their analysis on Questions instead. Charts are derived data; Pollster editors publish them and change them as editorial priorities change. 
    # @param slug Unique identifier for a Chart
    # @param [Hash] opts the optional parameters
    # @return [Array<(Chart, Fixnum, Hash)>] Chart data, response status code and response headers
    def charts_slug_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.charts_slug_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.charts_slug_get" if slug.nil?
      # resource path
      local_var_path = "/charts/{slug}".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Chart')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#charts_slug_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # One row per poll plotted on a Chart
    # Derived data presented on a Pollster Chart.  Rules for which polls and responses are plotted on a chart can shift over time. Here are some examples of behaviors Pollster has used in the past:  * We've omitted \"Registered Voters\" from a chart when \"Likely Voters\"   responded to the same poll question. * We've omitted poll questions that asked about Gary Johnson on a   chart about Trump v Clinton. * We've omitted polls when their date ranges overlapped. * We've omitted labels (and their responses) for dark-horse   candidates.  In short: this endpoint is about Pollster, not the polls. For complete data, use a TSV from the Questions API.  The response follows the exact same format as `questions/{slug}/poll-responses-clean.tsv`, which you should strongly consider before settling on the Chart TSV. 
    # @param slug Unique Chart identifier. For example: &#x60;obama-job-approval&#x60;
    # @param [Hash] opts the optional parameters
    # @return [PollsterChartPollQuestions]
    def charts_slug_pollster_chart_poll_questions_tsv_get(slug, opts = {})
      data, _status_code, _headers = charts_slug_pollster_chart_poll_questions_tsv_get_with_http_info(slug, opts)
      return data
    end

    # One row per poll plotted on a Chart
    # Derived data presented on a Pollster Chart.  Rules for which polls and responses are plotted on a chart can shift over time. Here are some examples of behaviors Pollster has used in the past:  * We&#39;ve omitted \&quot;Registered Voters\&quot; from a chart when \&quot;Likely Voters\&quot;   responded to the same poll question. * We&#39;ve omitted poll questions that asked about Gary Johnson on a   chart about Trump v Clinton. * We&#39;ve omitted polls when their date ranges overlapped. * We&#39;ve omitted labels (and their responses) for dark-horse   candidates.  In short: this endpoint is about Pollster, not the polls. For complete data, use a TSV from the Questions API.  The response follows the exact same format as &#x60;questions/{slug}/poll-responses-clean.tsv&#x60;, which you should strongly consider before settling on the Chart TSV. 
    # @param slug Unique Chart identifier. For example: &#x60;obama-job-approval&#x60;
    # @param [Hash] opts the optional parameters
    # @return [Array<(PollsterChartPollQuestions, Fixnum, Hash)>] PollsterChartPollQuestions data, response status code and response headers
    def charts_slug_pollster_chart_poll_questions_tsv_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.charts_slug_pollster_chart_poll_questions_tsv_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.charts_slug_pollster_chart_poll_questions_tsv_get" if slug.nil?
      # resource path
      local_var_path = "/charts/{slug}/pollster-chart-poll-questions.tsv".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['text/tab-separated-values']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api_tsv(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PollsterChartPollQuestions')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#charts_slug_pollster_chart_poll_questions_tsv_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Estimates of what the polls suggest about trends
    # Derived data presented on a Pollster Chart.  The trendlines on a Pollster chart don't add up to 100: we calculate each label's trendline separately.  Use the `charts/{slug}` response's `chart.pollster_estimates[0].algorithm` to find the algorithm Pollster used to generate these estimates.  Pollster recalculates trendlines every time a new poll is entered. It also recalculates trendlines daily if they use the `bayesian-kallman` algorithm, because that algorithm's output changes depending on the end date. 
    # @param slug Unique Chart identifier. For example: &#x60;obama-job-approval&#x60;
    # @param [Hash] opts the optional parameters
    # @return [ChartPollsterTrendlines]
    def charts_slug_pollster_trendlines_tsv_get(slug, opts = {})
      data, _status_code, _headers = charts_slug_pollster_trendlines_tsv_get_with_http_info(slug, opts)
      return data
    end

    # Estimates of what the polls suggest about trends
    # Derived data presented on a Pollster Chart.  The trendlines on a Pollster chart don&#39;t add up to 100: we calculate each label&#39;s trendline separately.  Use the &#x60;charts/{slug}&#x60; response&#39;s &#x60;chart.pollster_estimates[0].algorithm&#x60; to find the algorithm Pollster used to generate these estimates.  Pollster recalculates trendlines every time a new poll is entered. It also recalculates trendlines daily if they use the &#x60;bayesian-kallman&#x60; algorithm, because that algorithm&#39;s output changes depending on the end date. 
    # @param slug Unique Chart identifier. For example: &#x60;obama-job-approval&#x60;
    # @param [Hash] opts the optional parameters
    # @return [Array<(ChartPollsterTrendlines, Fixnum, Hash)>] ChartPollsterTrendlines data, response status code and response headers
    def charts_slug_pollster_trendlines_tsv_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.charts_slug_pollster_trendlines_tsv_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.charts_slug_pollster_trendlines_tsv_get" if slug.nil?
      # resource path
      local_var_path = "/charts/{slug}/pollster-trendlines.tsv".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['text/tab-separated-values']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api_tsv(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ChartPollsterTrendlines')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#charts_slug_pollster_trendlines_tsv_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Polls
    # A Poll on Pollster is a collection of questions and responses published by a reputable survey house. This endpoint provides raw data from the survey house, plus Pollster-provided metadata about each question.  Pollster editors don't include every question when they enter Polls, and they don't necessarily enter every subpopulation for the responses they _do_ enter. They make editorial decisions about which questions belong in the database.  The response will contain a maximum of 25 Poll objects, even if the database contains more than 25 polls. Use the `next_cursor` parameter to fetch the rest, 25 Polls at a time. 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Special string to index into the Array
    # @option opts [String] :tags Comma-separated list of Question tag names; only Polls containing Questions with any of the given tags will be returned.
    # @option opts [String] :question Question slug; only Polls that ask that Question will be returned.
    # @option opts [String] :sort If &#x60;updated_at&#x60;, sort the most recently updated Poll first. (This can cause race conditions when used with &#x60;cursor&#x60;.) Otherwise, sort by most recently _entered_ Poll first. (default to created_at)
    # @return [InlineResponse2003]
    def polls_get(opts = {})
      data, _status_code, _headers = polls_get_with_http_info(opts)
      return data
    end

    # Polls
    # A Poll on Pollster is a collection of questions and responses published by a reputable survey house. This endpoint provides raw data from the survey house, plus Pollster-provided metadata about each question.  Pollster editors don&#39;t include every question when they enter Polls, and they don&#39;t necessarily enter every subpopulation for the responses they _do_ enter. They make editorial decisions about which questions belong in the database.  The response will contain a maximum of 25 Poll objects, even if the database contains more than 25 polls. Use the &#x60;next_cursor&#x60; parameter to fetch the rest, 25 Polls at a time. 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Special string to index into the Array
    # @option opts [String] :tags Comma-separated list of Question tag names; only Polls containing Questions with any of the given tags will be returned.
    # @option opts [String] :question Question slug; only Polls that ask that Question will be returned.
    # @option opts [String] :sort If &#x60;updated_at&#x60;, sort the most recently updated Poll first. (This can cause race conditions when used with &#x60;cursor&#x60;.) Otherwise, sort by most recently _entered_ Poll first.
    # @return [Array<(InlineResponse2003, Fixnum, Hash)>] InlineResponse2003 data, response status code and response headers
    def polls_get_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.polls_get ..."
      end
      if opts[:'sort'] && !['created_at', 'updated_at'].include?(opts[:'sort'])
        fail ArgumentError, 'invalid value for "sort", must be one of created_at, updated_at'
      end
      # resource path
      local_var_path = "/polls".sub('{format}','json')

      # query parameters
      query_params = {}
      query_params[:'cursor'] = opts[:'cursor'] if !opts[:'cursor'].nil?
      query_params[:'tags'] = opts[:'tags'] if !opts[:'tags'].nil?
      query_params[:'question'] = opts[:'question'] if !opts[:'question'].nil?
      query_params[:'sort'] = opts[:'sort'] if !opts[:'sort'].nil?

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2003')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#polls_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Poll
    # A Poll on Pollster is a collection of questions and responses published by a reputable survey house. This endpoint provides raw data from the survey house, plus Pollster-provided metadata about each question.  Pollster editors don't include every question when they enter Polls, and they don't necessarily enter every subpopulation for the responses they _do_ enter. They make editorial decisions about which questions belong in the database. 
    # @param slug Unique Poll identifier. For example: &#x60;gallup-26892&#x60;.
    # @param [Hash] opts the optional parameters
    # @return [Poll]
    def polls_slug_get(slug, opts = {})
      data, _status_code, _headers = polls_slug_get_with_http_info(slug, opts)
      return data
    end

    # Poll
    # A Poll on Pollster is a collection of questions and responses published by a reputable survey house. This endpoint provides raw data from the survey house, plus Pollster-provided metadata about each question.  Pollster editors don&#39;t include every question when they enter Polls, and they don&#39;t necessarily enter every subpopulation for the responses they _do_ enter. They make editorial decisions about which questions belong in the database. 
    # @param slug Unique Poll identifier. For example: &#x60;gallup-26892&#x60;.
    # @param [Hash] opts the optional parameters
    # @return [Array<(Poll, Fixnum, Hash)>] Poll data, response status code and response headers
    def polls_slug_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.polls_slug_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.polls_slug_get" if slug.nil?
      # resource path
      local_var_path = "/polls/{slug}".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Poll')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#polls_slug_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Questions
    # Returns a list of Questions.  A Question is chosen by Pollster editors. One example is \"Obama job approval\".  Different survey houses may publish varying phrasings (\"Do you approve or disapprove\" vs \"What do you think of the job\") and prompt readers with varying responses (one poll might have \"Approve\" and \"Disapprove\"; another poll might have \"Strongly approve\" and \"Somewhat approve\"). Those variations do not appear in this API endpoint. 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Special string to index into the Array
    # @option opts [String] :tags Comma-separated list of Question tag names. Only Questions with one or more of these tags will be returned.
    # @option opts [Date] :election_date Date of an election, in YYYY-MM-DD format. Only Questions pertaining to an election on this date will be returned.
    # @return [InlineResponse2004]
    def questions_get(opts = {})
      data, _status_code, _headers = questions_get_with_http_info(opts)
      return data
    end

    # Questions
    # Returns a list of Questions.  A Question is chosen by Pollster editors. One example is \&quot;Obama job approval\&quot;.  Different survey houses may publish varying phrasings (\&quot;Do you approve or disapprove\&quot; vs \&quot;What do you think of the job\&quot;) and prompt readers with varying responses (one poll might have \&quot;Approve\&quot; and \&quot;Disapprove\&quot;; another poll might have \&quot;Strongly approve\&quot; and \&quot;Somewhat approve\&quot;). Those variations do not appear in this API endpoint. 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Special string to index into the Array
    # @option opts [String] :tags Comma-separated list of Question tag names. Only Questions with one or more of these tags will be returned.
    # @option opts [Date] :election_date Date of an election, in YYYY-MM-DD format. Only Questions pertaining to an election on this date will be returned.
    # @return [Array<(InlineResponse2004, Fixnum, Hash)>] InlineResponse2004 data, response status code and response headers
    def questions_get_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.questions_get ..."
      end
      # resource path
      local_var_path = "/questions".sub('{format}','json')

      # query parameters
      query_params = {}
      query_params[:'cursor'] = opts[:'cursor'] if !opts[:'cursor'].nil?
      query_params[:'tags'] = opts[:'tags'] if !opts[:'tags'].nil?
      query_params[:'election_date'] = opts[:'election_date'] if !opts[:'election_date'].nil?

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2004')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#questions_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Question
    # A Question is chosen by Pollster editors. One example is \"Obama job approval\".  Different survey houses may publish varying phrasings (\"Do you approve or disapprove\" vs \"What do you think of the job\") and prompt readers with varying responses (one poll might have \"Approve\" and \"Disapprove\"; another poll might have \"Strongly approve\" and \"Somewhat approve\"). Those variations do not appear in this API endpoint. 
    # @param slug Unique Question identifier. For example: &#x60;00c -Pres (44) Obama - Job Approval - National&#x60;. (Remember to URL-encode this parameter when querying.)
    # @param [Hash] opts the optional parameters
    # @return [Question]
    def questions_slug_get(slug, opts = {})
      data, _status_code, _headers = questions_slug_get_with_http_info(slug, opts)
      return data
    end

    # Question
    # A Question is chosen by Pollster editors. One example is \&quot;Obama job approval\&quot;.  Different survey houses may publish varying phrasings (\&quot;Do you approve or disapprove\&quot; vs \&quot;What do you think of the job\&quot;) and prompt readers with varying responses (one poll might have \&quot;Approve\&quot; and \&quot;Disapprove\&quot;; another poll might have \&quot;Strongly approve\&quot; and \&quot;Somewhat approve\&quot;). Those variations do not appear in this API endpoint. 
    # @param slug Unique Question identifier. For example: &#x60;00c -Pres (44) Obama - Job Approval - National&#x60;. (Remember to URL-encode this parameter when querying.)
    # @param [Hash] opts the optional parameters
    # @return [Array<(Question, Fixnum, Hash)>] Question data, response status code and response headers
    def questions_slug_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.questions_slug_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.questions_slug_get" if slug.nil?
      # resource path
      local_var_path = "/questions/{slug}".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Question')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#questions_slug_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # One row of response values per PollQuestion+Subpopulation concerning the given Question
    # We include one TSV column per response label. See `questions/{slug}` for the Question's list of response labels, which are chosen by Pollster editors. Each row represents a single PollQuestion+Subpopulation. The value for each label column is the sum of the PollQuestion+Subpopulation responses that map to that `pollster_label`. For instance, on a hypothetical row, the `Approve` column might be the sum of that poll's `Strongly Approve` and `Somewhat Approve`. After the first TSV columns -- which are always response labels -- the next column will be `poll_slug`. `poll_slug` and subsequent columns are described in this API documentation. During the lifetime of a Question, Pollster editors may add, rename or reorder response labels. Such edits will change the TSV column headers. Column headers after `poll_slug` are never reordered or edited (but we may add new column headers). Sometimes a Poll may ask the same Question twice, leading to two similar rows with different values. Those rows will differ by `question_text` or by the set of response labels that have values.
    # @param slug Unique Question identifier. For example: &#x60;00c -Pres (44) Obama - Job Approval - National&#x60;. (Remember to URL-encode this parameter when querying.)
    # @param [Hash] opts the optional parameters
    # @return [QuestionPollResponsesClean]
    def questions_slug_poll_responses_clean_tsv_get(slug, opts = {})
      data, _status_code, _headers = questions_slug_poll_responses_clean_tsv_get_with_http_info(slug, opts)
      return data
    end

    # One row of response values per PollQuestion+Subpopulation concerning the given Question
    # We include one TSV column per response label. See &#x60;questions/{slug}&#x60; for the Question&#39;s list of response labels, which are chosen by Pollster editors. Each row represents a single PollQuestion+Subpopulation. The value for each label column is the sum of the PollQuestion+Subpopulation responses that map to that &#x60;pollster_label&#x60;. For instance, on a hypothetical row, the &#x60;Approve&#x60; column might be the sum of that poll&#39;s &#x60;Strongly Approve&#x60; and &#x60;Somewhat Approve&#x60;. After the first TSV columns -- which are always response labels -- the next column will be &#x60;poll_slug&#x60;. &#x60;poll_slug&#x60; and subsequent columns are described in this API documentation. During the lifetime of a Question, Pollster editors may add, rename or reorder response labels. Such edits will change the TSV column headers. Column headers after &#x60;poll_slug&#x60; are never reordered or edited (but we may add new column headers). Sometimes a Poll may ask the same Question twice, leading to two similar rows with different values. Those rows will differ by &#x60;question_text&#x60; or by the set of response labels that have values.
    # @param slug Unique Question identifier. For example: &#x60;00c -Pres (44) Obama - Job Approval - National&#x60;. (Remember to URL-encode this parameter when querying.)
    # @param [Hash] opts the optional parameters
    # @return [Array<(QuestionPollResponsesClean, Fixnum, Hash)>] QuestionPollResponsesClean data, response status code and response headers
    def questions_slug_poll_responses_clean_tsv_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.questions_slug_poll_responses_clean_tsv_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.questions_slug_poll_responses_clean_tsv_get" if slug.nil?
      # resource path
      local_var_path = "/questions/{slug}/poll-responses-clean.tsv".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['text/tab-separated-values']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api_tsv(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'QuestionPollResponsesClean')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#questions_slug_poll_responses_clean_tsv_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # One row per PollQuestion+Subpopulation+Response concerning the given Question (Large)
    # Raw data from which we derived `poll-responses-clean.tsv`.  Each row represents a single PollQuestion+Subpopulation+Response. See the Poll API for a description of these terms.  Group results by `(poll_slug, subpopulation, question_text)`: that's how the survey houses group them.  This response can be several megabytes large. We encourage you to consider `poll-responses-clean.tsv` instead. 
    # @param slug Unique Question identifier. For example: &#x60;00c -Pres (44) Obama - Job Approval - National&#x60;. (Remember to URL-encode this parameter when querying.)
    # @param [Hash] opts the optional parameters
    # @return [QuestionPollResponsesRaw]
    def questions_slug_poll_responses_raw_tsv_get(slug, opts = {})
      data, _status_code, _headers = questions_slug_poll_responses_raw_tsv_get_with_http_info(slug, opts)
      return data
    end

    # One row per PollQuestion+Subpopulation+Response concerning the given Question (Large)
    # Raw data from which we derived &#x60;poll-responses-clean.tsv&#x60;.  Each row represents a single PollQuestion+Subpopulation+Response. See the Poll API for a description of these terms.  Group results by &#x60;(poll_slug, subpopulation, question_text)&#x60;: that&#39;s how the survey houses group them.  This response can be several megabytes large. We encourage you to consider &#x60;poll-responses-clean.tsv&#x60; instead. 
    # @param slug Unique Question identifier. For example: &#x60;00c -Pres (44) Obama - Job Approval - National&#x60;. (Remember to URL-encode this parameter when querying.)
    # @param [Hash] opts the optional parameters
    # @return [Array<(QuestionPollResponsesRaw, Fixnum, Hash)>] QuestionPollResponsesRaw data, response status code and response headers
    def questions_slug_poll_responses_raw_tsv_get_with_http_info(slug, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.questions_slug_poll_responses_raw_tsv_get ..."
      end
      # verify the required parameter 'slug' is set
      fail ArgumentError, "Missing the required parameter 'slug' when calling Api.questions_slug_poll_responses_raw_tsv_get" if slug.nil?
      # resource path
      local_var_path = "/questions/{slug}/poll-responses-raw.tsv".sub('{format}','json').sub('{' + 'slug' + '}', slug.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['text/tab-separated-values']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api_tsv(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'QuestionPollResponsesRaw')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#questions_slug_poll_responses_raw_tsv_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Tags
    # Returns the list of Tags.  A Tag can apply to any number of Charts and Questions; Charts and Questions, in turn, can have any number of Tags.  Tags all look `like-this`: lowercase letters, numbers and hyphens. 
    # @param [Hash] opts the optional parameters
    # @return [Array<Tag>]
    def tags_get(opts = {})
      data, _status_code, _headers = tags_get_with_http_info(opts)
      return data
    end

    # Tags
    # Returns the list of Tags.  A Tag can apply to any number of Charts and Questions; Charts and Questions, in turn, can have any number of Tags.  Tags all look &#x60;like-this&#x60;: lowercase letters, numbers and hyphens. 
    # @param [Hash] opts the optional parameters
    # @return [Array<(Array<Tag>, Fixnum, Hash)>] Array<Tag> data, response status code and response headers
    def tags_get_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: Api.tags_get ..."
      end
      # resource path
      local_var_path = "/tags".sub('{format}','json')

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      local_header_accept = ['application/json', 'application/xml']
      local_header_accept_result = @api_client.select_header_accept(local_header_accept) and header_params['Accept'] = local_header_accept_result

      # HTTP header 'Content-Type'
      local_header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(local_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Array<Tag>')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: Api#tags_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
