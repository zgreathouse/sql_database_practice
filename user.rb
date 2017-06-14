require_relative 'questions_db_connections'
require relative 'question'
class User
  attr_accessor :id, :first_name, :last_name
  def self.all
    data = QuestionsDBConnection.instance.execute('SELECT * FROM users')
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil if user.empty?
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDBConnection.instance.execute(<<-SQL, first_name, last_name)
      SELECT
        *
      FROM
        users
      WHERE
        first_name = ?
        AND
        last_name = ?
    SQL
    return nil unless user.length > 0
    User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def authored_questions
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil if user.empty?
    User.new(user.first)
  end
end
