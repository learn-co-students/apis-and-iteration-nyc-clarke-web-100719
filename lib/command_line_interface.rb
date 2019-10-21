def welcome
  puts "Welcome to Star Wars Search"
end

def get_character_from_user
  puts "please enter a character name"
  response = gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
  response.downcase
end
