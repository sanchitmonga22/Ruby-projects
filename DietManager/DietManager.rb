require './FoodDB'
require './Log'

class DietManager
  def initialize()
    @dbFile = "FoodDB.txt"
    @logFile = "DietLog.txt"
    @database = FoodDB.new(@dbFile)
    @log = Log.new(@logFile)
    @dbChanged = false
    @logChanged = false
  end
  
  #Handles the 'quit' command which exits the DietManager
  def command_quit
    
  end
  
  #Handles the 'save' command which saves the FoodDB and Log if necessary
  def command_save
    if @dbChanged
      @database.save
    end
    if @logChanged
      @log.save
    end
  end
  
  #Handles the 'new food' command which adds a new BasicFood to the FoodDB
  def command_newFood(name, calories)
    a=@database.add_basicFood(name,calories)
    @dbChanged=true
  end

  #Handles the 'new recipe' command which adds a new Recipe to the FoodDB
  def command_newRecipe(name, ingredients)
    a=@database.add_recipe(name,ingredients)
    @dbChanged=true
  end

  #Handles the 'print' command which prints a single item from the FoodDB
  def command_print(name)
    item=@database.get(name)
    item.to_s
  end

  #Handles the 'print all' command which prints all items in the FoodDB
  def command_printAll
    @database.basicFoods.each{|food|
      puts food.to_s
    }
    puts ""
    @database.recipes.each{|recipe|
      puts recipe.to_s
    }
  end

  #Handles the 'find' command which prints information on all items in the FoodDB matching a certain prefix
  def command_find(prefix)
    list=@database.find_matches(prefix)
    list.each do |i|
      puts i.to_s
    end
  end

  #Handles both forms of the 'log' command which adds a unit of the named item to the log for a certain date
  def command_log(name, date = Date.today)
    a=@log.add_logItem(name,date)
    @logChanged = true
  end

  #Handles the 'delete' command which removes one unit of the named item from the log for a certain date
  def command_delete(name, date)
    a=@log.remove_logItem(name,date)
    @logChanged = true
  end

  #Handles both forms of the 'show' command which displays the log of items for a certain date
  def command_show(date = Date.today)
    dates=@log.get_entries(date)
    if dates==nil
      puts "error"
      puts date
      return
    end
    dates.each do |d|
      puts d.to_s
    end
  end

  #Handles the 'show all' command which displays the entire log of items
  def command_showAll
    puts @log.get_entries(nil)
  end
  
end #end DietManager class

#MAIN

dietManager = DietManager.new

puts "Input a command > "
#Read commands from the user through the command prompt
$stdin.each{|line|
  puts ""
  a=0
  word=line.split(' ')
  if word[0].eql?("quit")
    a=1
  elsif word[0].eql?("save")
    dietManager.command_save
  elsif word[0].eql?("new")
    w=word[2].split(',')
    if word[1].eql?("food")
      dietManager.command_newFood(w[0],w[1])
    elsif word[1].eql?("recipe")
      recipeName=w[0]
      w.delete_at(0)
      dietManager.command_newRecipe(recipeName,w)
    end
  elsif word[0].eql?("print")
    if word[1].eql?("all")
      dietManager.command_printAll
    else
      if word.length==2
        puts dietManager.command_print(word[1])
      else
        puts dietManager.command_print("#{word[1]} #{word[2]}")
      end
    end
  elsif word[0].eql?("find")
    dietManager.command_find(word[1])
  elsif word[0].eql?("log")
    if word.length==2
      l=word[1].split(',')
      if l.length==1
        dietManager.command_log(l[0])
      elsif l.length==2
        dietManager.command_log(l[0],l[1])
      end
    elsif word.length==3
      fName="#{word[1]} #{word[2]}"
      l=fName.split(',')
      if l.length==1
        dietManager.command_log(l[0])
      elsif l.length==2
        dietManager.command_log(l[0],l[1])
      end
    end
  elsif word[0].eql?("delete")
    d=word[1].split(',')
    dietManager.command_delete(d[0],d[1])
  elsif word[0].eql?("show")
    if word.length==1
      dietManager.command_show
    elsif word[1].eql?("all")
      dietManager.command_showAll
    else
      d=word[1].split('/')
      date=Date.parse("#{d[2]}-#{d[0]}-#{d[1]}")
      dietManager.command_show(date)
    end
  else
    a=1
    puts "An error occured"
  end
  if a==1
    break
  end
  puts ""
  #Handle the input
}
