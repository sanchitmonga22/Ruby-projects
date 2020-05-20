require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative 'Recipe'

class RecipeTest < MiniTest::Test
  def setup
    @bread = BasicFood.new("Bread", 80)
    @pb = BasicFood.new("Peanut Butter", 175)
    @jelly = BasicFood.new("Jelly", 155)
    @recipe = Recipe.new("PB&J", [@bread, @pb, @jelly, @bread])
  end

  #Tests the initial construction of a Recipe
  def test_construction
 	assert(@recipe.name.eql?("PB&J"),"Name was not initialized correctly")
	assert(@recipe.calories==490, "Total number of calories do not match")
  end
  
  #Tests the 'to_s' method of Recipe
  def test_to_s
    sol="PB&J 490\n  Bread 80\n  Bread 80\n  Jelly 155\n  Peanut Butter 175\n"
	assert(@recipe.to_s.eql?(sol),"Output format incorrect")
  end
  
end
