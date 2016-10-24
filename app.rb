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



get '/:id/delete' do
@note = params[:id]
@title = "Confirm deletion of note ##{params[:id]}"
erb :delete
end

delete '/:id' do
 db = SQLite3::Database.open "tester.db"

  #db.execute "CREATE TABLE IF NOT EXISTS colors (Id INTEGER PRIMARY KEY, 
       # Name TEXT, Favorite TEXT)"

 n = params[:id]
 db.execute "delete from colors where id = '#{n}'"
 return "Item deleted"
end

get '/color/' do
  db = SQLite3::Database.open "tester.db"
  @list = db.execute "select * from colors"
  erb :colorform
end

post '/color/' do
  favorite = params[:favorite] || "Color"
    name = params[:name] || "Nobody"


 db = SQLite3::Database.open "tester.db"

	db.execute "CREATE TABLE IF NOT EXISTS colors (Id INTEGER PRIMARY KEY, 
        Name TEXT, Favorite TEXT)"

#where clause
    #reads through names
    val= db.get_first_value "select name from colors where Name = '#{name}'"
    #if name exists in database
  if val
    return "Name already exists in database"
    #if name does not exist in database
    else
  	db.execute "INSERT INTO colors (Name, Favorite) values ('#{name}', '#{favorite}')"
  end
db.close
end

#list = db.execute "*select* from colors"
#list.each.do


