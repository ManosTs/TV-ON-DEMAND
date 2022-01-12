
USE tvondemand;


--
-- Table structure for table `employee`
--

CREATE TABLE employee(
	  employee_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	  first_name VARCHAR(45) NOT NULL,
	  last_name VARCHAR(45) NOT NULL,
	  email VARCHAR(50) DEFAULT NULL,
	  address_id SMALLINT UNSIGNED NOT NULL,
	  create_date DATETIME NOT NULL,
	  admin BOOLEAN NOT NULL DEFAULT FALSE,
	  PRIMARY KEY  (employee_id),
	  CONSTRAINT fk_employee_address FOREIGN KEY (address_id) REFERENCES address (address_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `episode`
--

CREATE TABLE episode(
	  episode_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	  title VARCHAR(128) NOT NULL,
	  description TEXT DEFAULT NULL,
	  length SMALLINT UNSIGNED DEFAULT NULL,
	  release_year YEAR DEFAULT NULL,
	  PRIMARY KEY(episode_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `season`
--

CREATE TABLE season(
	  season_number TINYINT UNSIGNED NOT NULL,
	  episode_id SMALLINT UNSIGNED NOT NULL,
	  serie_id SMALLINT UNSIGNED NOT NULL,
	  PRIMARY KEY(episode_id,serie_id),
	  CONSTRAINT fk_episode_id FOREIGN KEY (episode_id) REFERENCES episode (episode_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  CONSTRAINT fk_serie_id FOREIGN KEY (serie_id) REFERENCES serie (serie_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `serie_category`
--
CREATE TABLE serie_category (
	  serie_id SMALLINT UNSIGNED NOT NULL,
	  category_id TINYINT UNSIGNED NOT NULL,
	  PRIMARY KEY (serie_id, category_id),
	  CONSTRAINT fk_serie_category_serie_id FOREIGN KEY (serie_id) REFERENCES serie (serie_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  CONSTRAINT fk_serie_category_category_id FOREIGN KEY (category_id) REFERENCES category (category_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `serie_actor`
--

CREATE TABLE serie_actor(
	  actor_id SMALLINT UNSIGNED NOT NULL,
	  serie_id SMALLINT UNSIGNED NOT NULL,
	  PRIMARY KEY  (actor_id,serie_id),
	  CONSTRAINT fk_serie_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  CONSTRAINT fk_serie_actor_serie_id FOREIGN KEY (serie_id) REFERENCES serie (serie_id) 
	  ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `log`
--

CREATE TABLE log(
	username VARCHAR(255) NOT NULL DEFAULT 'UNKNOWN',
	action_name varchar(255) NOT NULL,
	table_name varchar(255) NOT NULL,
	date DATETIME NOT NULL,
	execution VARCHAR(50) NOT NULL DEFAULT 'UNKNOWN'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


