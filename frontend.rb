require "unirest"
# print "enter email: "
# email = gets.chomp
# print "enter password: "
# password = gets.chomp
email = "peter@email.com"
password = "password"

# Login and set jwt as part of Unirest requests
response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: email,
      password: password
    }
  }
)
jwt = response.body["jwt"]
Unirest.default_header("Authorization", "Bearer #{jwt}")

system "clear"
puts "Your jwt is #{jwt}"
puts "Welcome to Recipes app! choose an option:"
puts "[1] See your Recipes"
puts "[2] Create a recipe"
puts "[3] Add directions"
puts "[4] Add ingredients"
puts "[5] Add fridge items"







input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/recipes")
  recipe = response.body 
  puts JSON.pretty_generate(recipe)

    elsif input_option == "2"
    print "name: "
    name = gets.chomp

    params = {
      "name" => name,
      
    } 
    response = Unirest.post("http://localhost:3000/v1/recipes", parameters: params)
    recipe = response.body 
    puts JSON.pretty_generate(recipe)

    elsif input_option == "3"
    print "text: "
    text = gets.chomp
    print "order: "
    order = gets.chomp
    print "recipe_id: "
    recipe_id = gets.chomp
    

    params = {
      "text" => text,
      "order" => order,
      "recipe_id" => recipe_id,

      
    } 
    response = Unirest.post("http://localhost:3000/v1/directions", parameters: params)
    direction = response.body 
    puts JSON.pretty_generate(direction)

        elsif input_option == "4"
    print "name: "
    name = gets.chomp
    print "recipe_id: "
    recipe_id = gets.chomp
    

    params = {
      "name" => name,
      "recipe_id" => recipe_id,

      
    } 
    response = Unirest.post("http://localhost:3000/v1/ingredients", parameters: params)
    ingredient = response.body 
    puts JSON.pretty_generate(ingredient)

            elsif input_option == "5"
    print "name: "
    name = gets.chomp


    params = {
      "name" => name,

      
    } 
    response = Unirest.post("http://localhost:3000/v1/fridge_items", parameters: params)
    fridge_item = response.body 
    puts JSON.pretty_generate(fridge_item)

end 

