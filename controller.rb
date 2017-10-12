require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/student')

get '/students' do
    @students = Student.all()
    erb (:index)
end

get '/students/new' do
  @houses = House.all()
  erb (:new)
end

get '/students/about' do
  erb ( :about )
end

get '/students/contact' do
  erb ( :contact )
end

get '/students/:id' do
  @student = Student.find(params['id'])
  erb ( :show )
end

get '/students/:id/edit' do
  @student = Student.find(params['id'])
  @houses = House.all()
  erb ( :edit )
end

post '/students/:id' do
  @student = Student.new(params)
  @student.update()
  erb ( :update )
end

post '/students/:id/delete' do
  @student = Student.find(params['id'])
  @student.delete()
  erb ( :delete )
end

post '/students' do
  @student = Student.new(params)
  @student.save()
  erb( :create )
end
