require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  character_hash = response_hash["results"].select {|character| character["name"] == character_name}

  film_hash = character_hash[0]["films"]

  # collect those film API urls, make a web request to each URL to get the info for that film
  # return value of this method should be collection of info about each film. 
  #i.e. an array of hashes in which each hash reps a given film

  films = film_hash.map do |film| 
    film_string = RestClient.get(film)
    JSON.parse(film_string)
    end

  films
end

def print_movies(films)
  films.each {|film| puts film["title"]}
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
