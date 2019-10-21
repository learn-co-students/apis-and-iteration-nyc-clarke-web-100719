require 'rest-client'
require 'json'
require 'pry'

def api_to_string(api_link)
  RestClient.get(api_link)
end

def json_to_hash(api_link)
  api_string = api_to_string(api_link)
  JSON.parse(api_string)
end

def find_character_from_api(character_name)
  response_hash = json_to_hash('http://www.swapi.co/api/people/')
  response_hash["results"].find do |character|
    character["name"].downcase == character_name.downcase
  end
end

def get_character_movies_from_api(character_name)
  #make the web request

  character_hash = find_character_from_api(character_name)

  if character_hash
    character_hash["films"].map do |apilink|
      film_string = RestClient.get(apilink)
      JSON.parse(film_string)
    end
  end

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  if films
    films.each do |film|
      puts "#{film["title"]} | #{film["release_date"]}"
    end
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?