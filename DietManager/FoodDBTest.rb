require 'minitest/autorun'          #We need Ruby's unit testing library
require './FoodDB'

class FoodDBTest < MiniTest::Test
  def setup							#setup method is run automatically before each test_xxx
    @fdb = FoodDB.new("FoodDB.txt")
  end
  
  #Tests if there are entries in the DB after FoodDB.txt is read
  def test_DB_initialization
    assert(@fdb.size > 0, "Database entries not correctly read in")
  end
  
  #Tests the 'contains_food?' method of FoodDB
  def test_contains_food
    assert(@fdb.contains_food?("Orange")==true,"Food items not checked correclty")
  end
  
  #Tests the 'contains_recipe?' method of FoodDB
  def test_contains_recipe
    assert(@fdb.contains_recipe?("Chicken Sandwich")==true,"Recipe items not checked correclty")
  end
  
  #Tests the 'contains?' method of FoodDB
  def test_contains
    assert(@fdb.contains?("Orange")==true,"Food items not checked correclty")
    assert(@fdb.contains?("Chicken Sandwich")==true,"Recipe items not checked correclty")
  end
  
  #Tests the 'get_food' method of FoodDB
  def test_get_food
    assert(@fdb.get_food("Orange")!=nil,"Cannot get the food from the database")
  end
  
  #Tests the 'get_recipe' method of FoodDB
  def test_get_recipe
    assert(@fdb.get_recipe("Chicken Sandwich")!=nil,"Cannot get the food from the database")
  end
  
  def test_get
    assert(@fdb.get_food("Orange")!=nil,"Cannot get the food from the database")
    assert(@fdb.get_recipe("Chicken Sandwich")!=nil,"Cannot get the food from the database")
  end
  
  #Tests the 'find_matches' method of FoodDB
  def test_find_matches
    a=@fdb.find_matches('C')
    assert(a.size==2,"There should be 2 items whose name start with C")
  end
  
  #Tests the 'add_basicFood' method
  def test_add_food
    assert(@fdb.add_basicFood("Orange",67)==false,"Food already exists in the database")
  end
  
  #Tests the 'add_recipe' method
  def test_add_recipe
    assert(@fdb.add_basicFood("Orange",67)==false,"Food already exists in the database")
  end
  
  #Tests the addition of a Recipe with a Recipe as one of its ingredients
  def test_recipe_within_recipe
    names=Array.new
    names[0]="Chicken Sandwich"
    names[1]="Bread Slice"
    names[2]="Peanut Butter"
#    names ="Chicken Sandwich","Bread Slice","Bread Slice","Peanut Butter"}
    assert(@fdb.add_recipe("Peanut Chicken Sandwich",names)==true,"Recipe within recipe couldnt be added")
  end
end
