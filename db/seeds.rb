require('pry-byebug')

require_relative('../models/house')
require_relative('../models/student')

Student.delete_all()
House.delete_all()

house1 = House.new({
  'name' => 'Gryffindor',
  'coat_of_arms' => 'Lion'
}
)

house1.save()

house2 = House.new({
  'name' => 'Slytherin',
  'coat_of_arms' => 'Serpent'
}
)

house2.save()


house3 = House.new({
  'name' => 'Ravenclaw',
  'coat_of_arms' => 'Eagle'
}
)

house3.save()


house4 = House.new({
  'name' => 'Hufflepuff',
  'coat_of_arms' => 'Badger'
}
)

house4.save()

student1 = Student.new({
  'first_name' => 'Harry',
  'last_name' => 'Potter',
  'age' => 16,
  'house_id' => house1.id
}
)

student1.save()


student2 = Student.new({
  'first_name' => 'Ron',
  'last_name' => 'Weasley',
  'age' => 16,
  'house_id' => house1.id
}
)

student2.save()

student3 = Student.new({
  'first_name' => 'Draco',
  'last_name' => 'Malfoy',
  'age' => 18,
  'house_id' => house2.id
}
)

student3.save()


student4 = Student.new({
  'first_name' => 'Cedric',
  'last_name' => 'Diggory',
  'age' => 19,
  'house_id' => house4.id
}
)

student4.save()

student5 = Student.new({
  'first_name' => 'Luna',
  'last_name' => 'Lovegood',
  'age' => 14,
  'house_id' => house3.id
}
)

student5.save()

pry.binding
nil
