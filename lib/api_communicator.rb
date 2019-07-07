require 'rest-client'
require 'json'
require 'pry'





def get_character_movies_from_api(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  url_array = []
  
  response_hash["results"].each do |char_hash|
    char_hash.each do |key, value|
      if key == "name" && value.downcase == character_name.downcase
        url_array << char_hash["films"]
        url_array = url_array.flatten
      end
    end
  end
  
  film_info_array = []

  url_array.each do |url|
    film_request = RestClient.get(url)
    film_info_array << JSON.parse(film_request)
  end
  
  film_info_array
end


def print_movies(films)
  films.each_with_index do |hash,index|
    puts "#{index+1} #{hash["title"]}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
