require_relative 'concordance'

# Command line interface to concordance
# THERE IS A BUG HERE YOU MUST FIX!
# Intended behavior
#  - Index the text line-by-line
#  - If --pretty was the one parameter, then pretty-print
#  - Otherwise, just print the concordance hash directly.

concordance = Concordance.new

$stdin.each do |line|
  concordance.process! line
end

if ARGV.empty? || ARGV[0].eql?('--pretty')
  puts concordance.pretty_format
else
  puts concordance.hash
end
