require_relative 'questions_db_connections'

class QuestionLike
  attr_accessor :id, :user_id, :question_id
  def self.all
    data = QuestionsDBConnection.instance.execute('SELECT * FROM question_like')
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    question_like = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    # return nil unless question_like.length > 0
    QuestionLike.new(question_like.first)
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
