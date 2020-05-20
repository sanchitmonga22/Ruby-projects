$stdin.each do |line|
  line=line.chomp
  line=line.downcase
  line=line.gsub(/[^a-zA-Z\s]/,"")
  line=line.sub(/^\s+/,"")
  puts line
end
