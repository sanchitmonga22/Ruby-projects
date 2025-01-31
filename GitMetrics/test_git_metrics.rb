require_relative 'git_metrics'
require 'minitest/autorun'

class TestGitMetrics < MiniTest::Test

  def test_commit_example
  	assert_equal 2, num_commits(["commit abc", "commit 123"]), "Should have counted two commits"
  end

  def test_dates_with_three_days
  	exp = [ "Date:  Sun Jan 26 21:25:22 2014 -0600", \
  			"Date:  Sun Jan 23 21:25:22 2014 -0600", \
  			"Date:  Sun Jan 25 21:25:22 2014 -0600"]
    assert_equal 4, days_of_development(exp), "Should have been a 4 days difference"
  end

  def test_num_developers
    exp=["Author: Jeff Felchner <accounts+git@thekompanee.com>", \
         "Author: aekym <me@aekym.com>", \
         "Author: Jeff Felchner <accounts+git@thekompane.com>"]
    assert_equal 3,num_developers(exp),"Should have been 3 developers"
  end

end
