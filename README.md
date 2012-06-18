pollster-ruby
=============

A Ruby wrapper for the Pollster API.


Usage
-------------

    >> require 'pollster'
    >> include Pollster

    # List all charts
    >> Chart.all

    # Get a specific chart
    >> Chart.find('2012-iowa-gop-primary')

    # List the polls for a specific chart
    >> chart = Chart.find('2012-iowa-gop-primary')
    >> chart.polls
