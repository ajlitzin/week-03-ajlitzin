require 'rubygems'
require 'highline/import'

# Refer to the documentation here for some more examples:
# @see http://rubydoc.info/gems/highline/1.6.2/frames
# 
# A bit of warning, highline is great, but the documentation of all the examples
# is not the best. During the next class we will review it in more detail so go
# as far as you are interested.
#
# I found this handy class on the net
# Reads a set number of lines from the top.
# Usage: File.head('path.txt')
class File
  def self.head(path, n = 1)
     open(path) do |f|
        lines = []
        n.times do
          line = f.gets || break
          lines << line
        end
        lines
     end
  end
end

def quotes(character, num_quotes)
  if character == "fry"
    quotefile="./lib/fryquotes.txt"
  else #char is bender
    quotefile="./lib/benderquotes.txt"
  end
  File.head(quotefile,num_quotes)
end

#if agree("You've chosen to see quotes, ok? ", true)
 # puts "yah"
#end  
proceed = ask("Do you want to hear some funny quotes? ") { |q| q.validate = /yes|no/i }
if proceed == "yes"

  character = choose do |menu|
    menu.prompt = "Do you like Fry or Bender? "
    menu.choice(:fry)
    menu.choice(:bender)
  end

# trying to figure out how to validate the answer and re-ask if it doesn't mat
#ask("Do you like Fry or Bender better? ") do |q|
#  q.validate = /fry|bender/i 
#  if not q.valid_answer?
#    say "dude, fry or bender?"
#  else character = q.response
#  end
#end

  character_icase = character.to_s.downcase
  if character_icase == "fry"
    maxquotes = 14
  else 
    maxquotes = 25
  end

  num_quotes = ask("How many quotes would you like to hear? 1 to #{maxquotes}", Integer) { |q| q.in = 1..maxquotes }
  if agree("You've chosen to see #{num_quotes} #{character_icase} quotes, ok? ", true)
    puts quotes(character_icase, num_quotes)
  end  
else
  puts "Later Gator"
end