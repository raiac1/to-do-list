require 'sinatra'
require 'sqlite3'
require 'sinatra/reloader'


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

#get '/:id/delete' do
#@note = params[:id]
#@title = "Confirm deletion of note #{params[:id]}"
#erb :delete
#end

#delete '/:id' do
# db = SQLite3::Database.open "tester.db"

# # db.execute "CREATE TABLE IF NOT EXISTS colors (Id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, password TEXT 
#       N0 TEXT, N2 TEXT)"
# n = params[:id]
# db.execute "delete from colors where id = '#{n}'"
# return "Item deleted"
#end

get '/colors/' do
  db = SQLite3::Database.open "tester.db"
  @list = db.execute "select * from colors"
  erb :colorform
end

post '/colors/' do
  
    N0 = params[:N0]||""
    N2 = params[:N2]||""
    first_name = params[:first_name] || ""
    last_name = params[:last_name] || ""
    email = params[:email] || ""
    password = params[:password] || ""
    logine= params[:logine]||""
    loginp= params[:loginp]||""



db = SQLite3::Database.open "tester.db"  
db.execute "INSERT INTO colors (N0, N2) values ('#{N0}', '#{N2}')"
db.close
end

get '/copic/' do
    db = SQLite3::Database.open "tester.db"
    erb :copicform

end
post '/copic/' do

    first_name = params[:first_name] || ""
    last_name = params[:last_name] || ""
    email = params[:email] || ""
    password = params[:password] || ""
    logine= params[:logine]||""
    loginp= params[:loginp]||""



db = SQLite3::Database.open "tester.db"

#where clause for sign up
    #reads through user names
    val= db.get_first_value "select email from colors where email = '#{email}'"
    #if name user exists in database
 if val
  return "Name already exists in database"
    #if name does not exist in database
   else
	db.execute "INSERT INTO colors (first_name, last_name, email, password) values ('#{first_name}', '#{last_name}', '#{email}', '#{password}')"
db.close
end

get '/login/' do
    db = SQLite3::Database.open "tester.db"
    erb :loginform 
end

post '/login/' do

    logine= params[:logine]||""
    loginp= params[:loginp]||""

    db = SQLite3::Database.open "tester.db" 

 val1= db.get_first_value "select email from colors where email = '#{logine}'"
 val1= db.get_first_value "select password from colors where password = '#{loginp}'"
if val1
  return '/colors/'
else
  return "Incorrect Email/Password"
db.close
end
end
end
