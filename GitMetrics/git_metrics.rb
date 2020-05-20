# Script that obtains various git metrics from a basic git log file
require 'set'
require 'date'

# Given an array of git log lines, count the number of commits in the log
def num_commits(lines)
  count=0
  lines.each do |line|
    arr=line.split(/ +/)
    if arr[0].eql?("commit")
      count+=1
    end
  end
  count            
end

# Given an array of git log lines, count the number of different authors
#   (Don't double-count!)
# You may assume that emails make a developer unique, that is, if a developer
# has two different emails they are counted as two different people.
def num_developers(lines)
  count=0
  email=""
  search=Array.new
  i=0
  lines.each do |line|
    line=line.chomp.split(/ +/)
    if line[0].eql?("Author:")
      email=line[-1].gsub(/[<>]/,"")
      search[i]=email
      i+=1
    end
  end
  search=search.uniq
  count=search.length
  return count
end

# Given an array of Git log lines, compute the number of days this was in development
# Note: you cannot assume any order of commits (e.g. you cannot assume that the newest commit is first).
def days_of_development(lines)
  m=""
  d=""
  y=""
  dates=Array.new
  i=0
  lines.each do |line|
    line=line.chomp.split(/ +/)
    if line[0].eql?("Date:")
      m=line[2]
      d=line[3]
      y=line[-2]
      dates[i]=Date.parse("#{d} #{m} #{y}")
      i+=1
    end
  end
  dates=dates.sort
  diff=dates[-1]-dates[0]
  return diff.to_i+1
end

# This is a ruby idiom that allows us to use both unit testing and command line processing
# Does not get run when we use unit testing, e.g. ruby test_git_metrics.rb
# These commands will invoke this code with our test data: 
#    ruby git_metrics.rb < ruby-progressbar-short.txt
#    ruby git_metrics.rb < ruby-progressbar-full.txt
if __FILE__ == $PROGRAM_NAME
  lines = []
  $stdin.each { |line| lines << line }
  puts "Nunber of commits: #{num_commits lines}"
  puts "Number of developers: #{num_developers lines}"
  puts "Number of days in development: #{days_of_development lines}"
end

