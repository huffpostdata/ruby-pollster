require 'test/unit'
require 'pollster'
include Pollster

class PollsterTest < Test::Unit::TestCase

  def test_ge_chart
    assert_equal "US", Chart.find('2012-general-election-romney-vs-obama').state
  end

  def test_poll_page_size
    assert_equal 10, Poll.all.size
  end

end