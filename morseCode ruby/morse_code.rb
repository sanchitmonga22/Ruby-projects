# Convert words to/from Morse code.
# Tom Reichlmayr, RIT 2/3/2008
# Revised by Mike Lutz, RIT, 2/3/2008
# Revised by Andy Meneely, RIt, 9/29/2014
# Revised by Sanchit Monga, RIT, 04/18/2019

# Translate a word (letters) to Morse code. Returns the Morse code string
# (with a space between the codes for adjacent letters).
# Map from characters to Morse code

LETTERS_TO_MORSE = {
    "A" => ".-",
    "B" => "-...",
    "C" => "-.-.",
    "D" => "-..",
    "E" => ".",
    "F" => "..-.",
    "G" => "--.",
    "H" => "....",
    "I" => "..",
    "J" => ".---",
    "K" => "-.-",
    "L" => ".-..",
    "M" => "--",
    "N" => "-.",
    "O" => "---",
    "P" => ".--.",
    "Q" => "--.-",
    "R" => ".-.",
    "S" => "...",
    "T" => "-",
    "U" => "..-",
    "V" => "...-",
    "W" => ".--",
    "X" => "-..-",
    "Y" => ".-.-",
    "Z" => "--.."
}

# Translate from normal language to Morse code
#
# Given:  a string of letters and anything else
# Return: a space-delimited string of letters in Morse code
# 
# Ignore any non-alphabetic characters.
# Must base case-insensitive
def to_morse(str)
  out=""
  if str==""
    return ""
  end
  str.each_char do |char|
    if LETTERS_TO_MORSE.include? char
      out+=LETTERS_TO_MORSE[char]+" "
    elsif
      LETTERS_TO_MORSE.include? char.upcase
      out+=LETTERS_TO_MORSE[char.upcase]+" "
    end
  end
  return out
end

# Translate Morse code to the alphabetic (word) equivalent.
# Given: a space-delimited string of morse code, with possible other characters
# Return: a string of characters decoded from Morse code.
# 
# Ignore any characters that are not spaces, periods, or dashes.
def from_morse(morse)
  if morse.eql? ""
    return ""
  end
  regex=/[^\s.-]/
  ans=""
  arr=morse.split(/ +/)
   arr.each do |word|
    if word.match regex
    else
      ans+=LETTERS_TO_MORSE.key(word)
    end
  end
  return ans
end



