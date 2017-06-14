require_relative 'questions_db_connections'

class Reply
  attr_accessor :id, :author_id, :parent_id, :body, :question_id
  def self.all
    data = QuestionsDBConnection.instance.execute('SELECT * FROM replies')
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def self.find_by_author_id(author_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @author_id = options['author_id']
    @parent_id = options['parent_id']
    @body = options['body']
    @question_id = options['question_id']
  end
end
