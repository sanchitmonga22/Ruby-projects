require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative './LogItem'

class LogItemTest < MiniTest::Test
  def setup
    @item = LogItem.new("Orange", Date.today)
  end
  
  #Tests the basic construction of a LogItem object
  def test_construction
    assert(@item.name.eql?("Orange"),"Item name not matched")
    assert(@item.date.eql?(Date.today),"Item date not matched")
  end
  
  #Tests the 'to_s' method of LogItem
  def test_to_s
    d=Date.today
    assert(@item.to_s.eql?("#{d.mon}/#{d.mday}/#{d.year}\n  Orange"),"Output format not valid")
  end
  
end
