require_relative('../db/sql_runner')
require_relative('house')

class Student

 attr_accessor :first_name, :last_name, :age, :house_id
  attr_reader :id

 def initialize( options )
    @id = options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @age = options['age'].to_i
    @house_id = options['house_id'].to_i
  end

 def student_name()
    return "#{@first_name} #{@last_name}"
  end

 def save()
    sql = "INSERT INTO students
    (
      first_name,
      last_name,
      age,
      house_id
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *"
    values = [@first_name, @last_name, @age, @house_id]
    student_data = SqlRunner.run(sql, values)
    @id = student_data.first()['id'].to_i
  end

 def update()
    sql = "UPDATE students
    SET
    (
      first_name,
      last_name,
      age,
      house_id
    ) = (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@first_name, @last_name, @age, @house_id, @id]
    SqlRunner.run( sql, values )
  end

 def delete()
    sql = "DELETE FROM students
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

 def self.delete_all()
    sql = "DELETE FROM students"
    values = []
    SqlRunner.run( sql, values )

 end

 def self.all()
    sql = "SELECT * FROM students"
    values = []
    students = SqlRunner.run( sql, values )
    result = students.map { |student| Student.new( student ) }
    return result
  end

 def self.find( id )
    sql = "SELECT * FROM students WHERE id = $1"
    values = [id]
    student = SqlRunner.run( sql, values )
    result = Student.new( student.first )
    return result
  end

 def house()
    sql = "SELECT houses.name FROM houses LEFT JOIN students ON houses.id = students.house_id WHERE students.id = $1;"
    values = [@id]
    houses = SqlRunner.run(sql, values)
    result = houses.map { |house| House.new(house)  }
    return houses[0].values.first
  end

 def self.houses()
    sql = "SELECT houses.* FROM houses LEFT JOIN students ON houses.id = students.house_id;"
    values = []
    houses = SqlRunner.run(sql, values)
    result = houses.map { |house| House.new(house)  }
    return result
  end

end
