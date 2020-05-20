# Unit tests for student developed tests

require_relative 'concordance'
require 'minitest/autorun'          #We need Ruby's unit testing library

class ConcordanceTest < MiniTest::Test

  # Remember: this gets run prior to each individual test_* method
  def setup
    @concordance = Concordance.new
  end

  # Fill in these tests as described

  # Create a test for the clean method that confirms that one or more '@' signs
  #   are replaced with space characters. Use the input string 'test@@one@two'
  def test_clean_at_sign
    #assert false  # bogus assert -- remove or comment out
    assert(@concordance.clean("test@@one@two").eql?("test  one two"),"Clean function not working properly")
  end

  # Create a test for the get_words method that correctly handles lots of spaces.
  #    Use this string:
  #    '   seven    seventy    seven  '
  def test_get_words_many_spaces
    #assert false  # bogus assert -- remove or comment out
    assert(@concordance.get_words("   seven    seventy    seven  ").length==4,"Number of words returned wrong")
    assert(@concordance.get_words("   seven    seventy    seven  ").include?("seven"),"Does not include all the words")
    assert(@concordance.get_words("   seven    seventy    seven  ").include?("seventy"),"Does
not include all the words")

  end

  # Create a test for the index! method that confirms that a line with just one repeated word is only listed
  #   once in the hash table. Call the .index! method with this array ['zero', 'zero', 'zero']
  def test_index_one_repeated_word
    #assert false  # bogus assert -- remove or comment out
    @concordance.index!(['zero','zero','zero'])
    assert_equal({'zero'=>[1]},@concordance.hash)
  end
end
