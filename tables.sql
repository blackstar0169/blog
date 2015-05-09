SET NAMES utf8;

-- Table editors

DROP TABLE IF EXISTS comments ;
DROP TABLE IF EXISTS posts_categories;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS editors;
DROP TABLE IF EXISTS categories;


CREATE TABLE editors (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  password VARCHAR(45) NOT NULL,
  mail VARCHAR(100) NOT NULL,
  date_registration DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  public TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  CONSTRAINT unique_editors UNIQUE (name, mail)
  )
ENGINE = InnoDB;


-- Table posts

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  content LONGTEXT NOT NULL,
  summary TEXT NULL,
  date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  editors_id INT NOT NULL,
  PRIMARY KEY (id),  
  FOREIGN KEY (editors_id) REFERENCES editors (id)
  )
ENGINE = InnoDB;


-- Table categories

CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (name)
  )
ENGINE = InnoDB;


-- Table posts_categories

CREATE TABLE posts_categories (
  posts_id INT NOT NULL,
  categories_id INT NOT NULL,
  PRIMARY KEY (posts_id, categories_id),
  FOREIGN KEY (posts_id) REFERENCES posts (id),  
  FOREIGN KEY (categories_id) REFERENCES categories (id)
)
ENGINE = InnoDB;


-- Table comments

CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  autor VARCHAR(30) NOT NULL,
  content TEXT NOT NULL,
  date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  posts_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (posts_id) REFERENCES posts (id)
)    
ENGINE = InnoDB;

DROP TRIGGER IF EXISTS posts_deleting;

DELIMITER //

CREATE TRIGGER posts_after_delete
BEFORE DELETE
   ON posts FOR EACH ROW
   
BEGIN

  DELETE FROM comments WHERE posts_id = OLD.id;
   
END; //

DELIMITER ;
