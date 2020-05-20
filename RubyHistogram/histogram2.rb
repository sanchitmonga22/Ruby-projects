$stdin.each do |line|
  line=line.split(/ +/)
  bag=Hash.new(0)
  line.each{|line| bag[line]+=1}
  arr=bag.select{|key,value| value>=2}
  arr.each{|key,value| puts "#{key} #{value}"}
end
