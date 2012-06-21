pollster-ruby
=============

A Ruby wrapper for the [Pollster API](http://elections.huffingtonpost.com/pollster/api).


Usage
-------------

Require the Pollster package

    >> require 'pollster'

List all charts

    >> Pollster::Chart.all

Get a specific chart

    >> Pollster::Chart.find('2012-iowa-gop-primary')

List the polls for a specific chart

    >> chart = Pollster::Chart.find('2012-iowa-gop-primary')
    >> chart.polls
