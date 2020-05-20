require './BasicFood'
require './Recipe'

class FoodDB
  attr_reader :size, :basicFoods, :recipes
  
  #filename is the name of the FoodDB file to be used, ex: "FoodDB.txt"
  def initialize(filename)
    @size = 0
  
    @dbFile = File.new(filename) #Open the database file
    
    @basicFoods = []
    @recipes = []
    
    #Read in the FoodDB file
    @dbFile.each{|line|
      values = line.split(',') #Split the line up at the commas      
      if values[1] == 'b' #BasicFood case
        add_basicFood(values[0], values[2].to_i) #Add the new food to our list
      elsif values[1] == 'r' #Recipe case
        values[2..values.length].each{|ingredient| ingredient.chomp!} #Remove newline characters
        add_recipe(values[0], values[2..values.length]) #Add the new Recipe to the recipes list
      else #The entry is invalid
        values[0].chomp.eql?("") ? nil : puts("Invalid food type found in FoodDB.txt")
      end
    }
  end
  
  #Returns true if a BasicFood with the name foodName exists in the database
  def contains_food?(foodName)
    contains = false
    @basicFoods.each do |food|
      if food.name.eql?(foodName)
        return true
      end
    end
    contains
  end
  
  #Returns true if a Recipe with the name recipeName exists in the database
  def contains_recipe?(recipeName)
    contains = false
    @recipes.each do |recipe|
      if recipe.name.eql?(recipeName)
        return true
      end
    end
    contains
  end
  
  #Returns true if there exists some entry in the database with the name itemName
  def contains?(itemName)
	contains=false
	if contains_food?(itemName) or contains_recipe?(itemName)
	  contains=true
	end
	contains
  end
  
  #Returns the BasicFood of the given name if it exists within the database, nil otherwise
  def get_food(foodName)
    f=nil
    @basicFoods.each do |food|
      if food.name.eql?(foodName)
        f=food
        break
      end
    end
    f
  end
  
  #Returns the Recipe of the given name if it exists within the database, nil otherwise
  def get_recipe(recipeName)
    recipe=nil
    @recipes.each do |food|
      if food.name.eql?(recipeName)
        recipe=food
        break
      end
    end
    recipe
  end
  
  #Returns the item of the given name if it exists within the database, nil otherwise
  def get(itemName)
    #If the item is a BasicFood and is in the database, return it
    #Else, if the item is a Recipe and is in the database, return it
    #Return nil otherwise
    food=nil
    food=get_food(itemName)
    if food==nil
      food=get_recipe(itemName)
    end
    food
  end
  
  #Returns a list of all items in the database that begin with the given prefix
  def find_matches(prefix)
    list=Array.new
    @basicFoods.each do |f|
      if f.name.start_with?(prefix)
        list.push(f)
      end
    end
    @recipes.each do |r|
      if r.name.start_with?(prefix)
        list.push(r)
      end
    end
    list
  end
  
  #Constructs a new BasicFood and adds it to the database, returns true if successful, false otherwise
  def add_basicFood(name, calories)
    food=BasicFood.new(name,calories)
    added=false
    if !contains_food?(food.name)
      @basicFoods.push(food)
      @size+=1
      added=true
    end
    added
  end
  
  #Constructs a new Recipe and adds it to the database, returns true if successful, false otherwise
  def add_recipe(name, ingredientNames)
    j=0
    ingredients=Array.new
    ingredientNames.each do |food|
      ingredients[j]=get(food)
      j+=1
    end
    food=Recipe.new(name,ingredients)
    added=false
    if !contains_recipe?(food.name)
      @recipes.push(food)
      @size+=1
      added=true
    end
    added
  end
  
  #Saves the database to @dbFile
  def save
    File.open(@dbFile, "w+"){|fOut|
      #Write all BasicFoods to the database
      @basicFoods.each{|food| fOut.write("#{food.name},b,#{food.calories}\n")}
      fOut.write("\n")
      
      #Write all Recipes to the database
      @recipes.each{|recipe|
        fOut.write("#{recipe.name},r")
        
        #List the ingredients after the recipe name
        recipe.ingredients.each{|ingredient| fOut.write(",#{ingredient.name}")}
        fOut.write("\n")
      }
    }
  end
end
