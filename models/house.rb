require_relative('../db/sql_runner')
require_relative('student')

class House

  attr_accessor :name, :coat_of_arms
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @coat_of_arms = options['coat_of_arms']
  end

  def house_name()
    return "#{@name} #{@coat_of_arms}"
  end

  def save()
    sql = "INSERT INTO houses
    (
      name,
      coat_of_arms
    )
    VALUES
    (
      $1, $2
    )
    RETURNING *"
    values = [@name, @coat_of_arms]
    house_data = SqlRunner.run(sql, values)
    @id = house_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE houses
    SET
    (
      name,
      coat_of_arms
    ) = (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @coat_of_arms, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM houses
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM houses"
    values = []
    SqlRunner.run( sql, values )

  end

  def self.all()
    sql = "SELECT * FROM houses"
    values = []
    houses = SqlRunner.run( sql, values )
    result = houses.map { |house| House.new( house ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    house = SqlRunner.run( sql, values )
    result = House.new( house.first )
    return result
  end

  def student()
     sql = "SELECT students.* FROM students WHERE house_id = $1;"
     values = [@id]
     students = SqlRunner.run(sql, values)
     return students.map {|student| Student.new(student)}
   end

end
