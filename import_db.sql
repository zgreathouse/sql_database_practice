DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  author_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (parent_id) REFERENCES replies(id), --point to parent id (if there is one)
  FOREIGN KEY (author_id) REFERENCES users(id), --point to user (author)
  FOREIGN KEY (question_id) REFERENCES questions(id) --subject question pointer
);

DROP TABLE IF EXISTS questions_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (first_name, last_name)
VALUES
  ('Zach', 'Greathouse'),
  ('Mallik', 'Begur');

INSERT INTO
  questions (title, body, author_id)
VALUES
    ('Pokemon location?', 'Where da hell dat charizard doh?', 1),
    ('R Kelly age?', 'Hey, how old R Kelly doh?', 2);

INSERT INTO
  replies (author_id, parent_id, body, question_id)
VALUES
  (2, NULL, 'You don''t have enough gym badges bruh', 1),
  (1, 2, 'Professor Oak gave me a charmander fo freee', 1);

  INSERT INTO
    question_follows (user_id, question_id)
  VALUES
    (1, 2);

  INSERT INTO
    question_likes (user_id, question_id)
  VALUES
    (2, 1);
