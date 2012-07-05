          :::::::::   ::::::::  :::        :::        :::::::: ::::::::::: :::::::::: :::::::::    |                   ,*
         :+:    :+: :+:    :+: :+:        :+:       :+:    :+:    :+:     :+:        :+:    :+:    |                 ,*
        +:+    +:+ +:+    +:+ +:+        +:+       +:+           +:+     +:+        +:+    +:+     |             ,*,*
       +#++:++#+  +#+    +:+ +#+        +#+       +#++:++#++    +#+     +#++:++#   +#++:++#:       |     ,*,   ,*
      +#+        +#+    +#+ +#+        +#+              +#+    +#+     +#+        +#+    +#+       |   ,*   *,*
     #+#        #+#    #+# #+#        #+#       #+#    #+#    #+#     #+#        #+#    #+#        | ,*
    ###         ########  ########## ########## ########     ###     ########## ###    ###         |*
                                                                                                    - - - - - - - - - - - 
  

A Ruby wrapper for the [Pollster API](http://elections.huffingtonpost.com/pollster/api) 
which provides access to political opinion polling data and trend estimates from The Huffington Post.

The Pollster gem has been tested under Ruby 1.8.7, 1.9.2 and 1.9.3.

## Installation

    gem install pollster

## Getting Started

    require 'pollster'
    include Pollster

See the current estimate of the president's job approval

    Chart.find('obama-job-approval').estimates

List charts about 2012 senate races

    Chart.where(:topic => '2012-senate')

List charts about Wisconsin

    Chart.where(:state => 'WI')

Calculate the margin between Obama and Romney from a recent general election poll

    poll = Poll.where(:chart => '2012-general-election-romney-vs-obama').first
    question = poll.questions.detect { |question| question[:chart] == '2012-general-election-romney-vs-obama' }
    obama = question[:responses].detect { |response| response[:choice] == "Obama" }
    romney = question[:responses].detect { |response| response[:choice] == "Romney" }
    obama[:value] - romney[:value]

See the methodology used in recent polls about the Affordable Care Act

    chart = Chart.find 'us-health-bill'
    chart.polls.map { |poll| [poll.pollster, poll.method] }

## Usage

Pollster provides two classes:

    Pollster::Chart

represents the current estimates for a Pollster chart (e.g. [Romney vs. Obama](http://elections.huffingtonpost.com/pollster/2012-general-election-romney-vs-obama))

    Pollster::Poll

represents a specific poll conducted by a polling firm.

### Accessing data

List all the charts available from Pollster:

    >> Pollster::Chart.all
    => [<Pollster::Chart: 2012 Iowa GOP Primary>,
        <Pollster::Chart: 2012 New Hampshire GOP Primary>,
        <Pollster::Chart: 2012 South Carolina GOP Primary>,
        <Pollster::Chart: 2012 Florida GOP Primary>,
        <Pollster::Chart: 2012 Nevada GOP Primary>,
        ...]

This response is not paginated; all charts will be returned.

A specific chart may be accessed using Pollster::Chart#find, giving the chart's slug as an argument:

    >> Pollster::Chart.find('2012-iowa-gop-primary')
    => <Pollster::Chart: 2012 Iowa GOP Primary>

All the charts for a topic or state may be accessed using Pollster::Chart#where:

    >> Pollster::Chart.where(:state => 'MD')
    => [<Pollster::Chart: 2012 Maryland GOP Primary>,
        <Pollster::Chart: 2012 Maryland House: 6th District>,
        <Pollster::Chart: 2012 Maryland President: Romney vs. Obama>]

    >> Pollster::Chart.where(:topic => '2012-senate')
    => [<Pollster::Chart: 2012 Massachusetts Senate: Brown vs Warren>,
        <Pollster::Chart: 2012 Ohio Senate: Brown vs Mandel>,
        <Pollster::Chart: 2012 Arizona Senate: Flake vs. Carmona>,
        <Pollster::Chart: 2012 Florida Senate: Mack vs. Nelson>,
        ...]

    >> Pollster::Chart.where(:topic => '2012-senate', :state => 'MA')
    => [<Pollster::Chart: 2012 Massachusetts Senate: Brown vs Warren>]

List the polls that were used to create the estimate for a specific chart:

    >> chart = Pollster::Chart.find('2012-iowa-gop-primary')
    >> chart.polls
    => [#<Pollster::Poll:...
      @end_date=#<Date: 2012-01-01 (4911855/2,0,2299161)>,
      @id=12385,
      @method="Automated Phone",
      @pollster="InsiderAdvantage",
      @questions=
       [{:name=>"2012 Iowa GOP Primary",
         :chart=>"2012-iowa-gop-primary",
         :topic=>"2012-gop-primary",
         :state=>"IA",
         :responses=>
          [{:choice=>"Undecided",
            :value=>2,
            :subpopulation=>"Likely Voters",
            :number_of_observations=>729,
            :margin_of_error=>nil},
           {:choice=>"Bachmann",
            :value=>6,
            :subpopulation=>"Likely Voters",
            :number_of_observations=>729,
            :margin_of_error=>nil},
           {:choice=>"Romney",
            :value=>23,
            :subpopulation=>"Likely Voters",
            :number_of_observations=>729,
            :margin_of_error=>nil},
          ...]

You may also list all polls available through Pollster:

    >> Pollster::Poll.all

This response is paginated, with 10 polls per page. To access subsequent pages, provide a page argument:

    >> Pollster::Poll.all(:page => 5)

## Authors

- Aaron Bycoffe, bycoffe@huffingtonpost.com
- Jay Boice, jay.boice@huffingtonpost.com

## Copyright

Copyright © 2012 The Huffington Post. See LICENSE for details.
