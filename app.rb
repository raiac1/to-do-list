require 'sinatra'
require 'sqlite3'


set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

#get '/' do
 #   return 'Hello world'
#end

#get '/hello/' do
 #   erb :hello_form
#end

#modify this for database
#post '/hello/' do
#    greeting = params[:greeting] || "Hi There"
 #   name = params[:name] || "Nobody"

  #  erb :index, :locals => {'greeting' => greeting, 'name' => name}
#end
get '/color/' do
	erb :colorform
end
post '/color/' do
	favorite = params[:favorite] || "Color"
    name = params[:name] || "Nobody"



 db = SQLite3::Database.open "tester.db"

	db.execute "CREATE TABLE IF NOT EXISTS colors (Id INTEGER PRIMARY KEY, 
        Name TEXT, Favorite TEXT)"

    val= db.get_first_value "select name from colors where Name = '#{name}'"
  if val
    puts "name already exists in database"
    else
  	db.execute "INSERT INTO colors (Name, Favorite) values ('#{name}', '#{favorite}')"
  end

  
  	db.close
end

