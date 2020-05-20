require './BasicFood'

class Recipe
  attr_accessor :name, :ingredients, :calories

  #recipeName is the name of this recipe and ingredientsList is the list of BasicFood objects in this recipe
  def initialize(recipeName, ingredientsList)
    @name = recipeName
    @ingredients = ingredientsList.sort{|x, y| x.name <=> y.name} #Sorts the list by ingredient name
    @calories = 0
    #Calculate the total calories in this Recipe
    @ingredients.each{|ingredient|
	    @calories+=ingredient.calories
    } 	
  end
  
  #Returns a string representation of this Recipe formatted for printing
  def to_s
    result=""
    result="#{@name} #{@calories}\n"
    @ingredients.each{|ingredient|
	    result+="  #{ingredient.to_s}\n"
    }
    result
  end
end
