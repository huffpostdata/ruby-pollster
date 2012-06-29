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

  def test_invalid_chart_slug
    assert_raise(Exception) { Chart.find('invalid-slug') }
  end

  def test_estimates_by_date
    assert_block do
      chart = Chart.all.first
      chart.estimates_by_date.is_a?(Array)
    end
  end

end
