-- DROP TRIGGER IF EXISTS checkPersonEmailPattern;
-- 
-- DELIMITER $
-- 
-- CREATE TRIGGER checkPersonEmailPattern
-- BEFORE INSERT 
-- ON person
-- FOR EACH ROW
-- BEGIN 
-- 	IF NOT (NEW.email LIKE '%@%.%')
-- 		THEN 
-- 			SET NEW.email = 'error';
-- 	END IF;
-- END$
-- 
-- DELIMITER ;

-- DROP TRIGGER IF EXISTS checkBusinessTitle;
-- 
-- DELIMITER $
-- 
-- CREATE TRIGGER checkBusinessTitle
-- BEFORE INSERT 
-- ON belongs
-- FOR EACH ROW
-- BEGIN 
-- 	DECLARE titleCount INT;
-- 
-- 	SELECT COUNT(*) INTO titleCount FROM business b
-- 	INNER JOIN chamber c ON c.name = NEW.ch_name
-- 	WHERE b.id = NEW.bus_id AND 
-- 	b.title IN(SELECT title FROM business b2 WHERE b2.id = NEW.bus_id);
-- 
-- 	IF(titleCount > 0)
-- 		THEN
-- 			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'DUPLICATED TITLE';
-- 	END IF;
-- 	
-- END$
-- DELIMITER ;

DROP TRIGGER IF EXISTS checkIfDatesDiffAWeek;

DELIMITER $

CREATE TRIGGER checkIfDatesDiffAWeek
BEFORE INSERT 
ON auditor_check
FOR EACH ROW
BEGIN 
	DECLARE dayCount INT;

	SELECT datediff(NEW.startdate,NEW.enddate) INTO dayCount; 

	IF(dayCount < 7)
		THEN
			SET NEW.enddate = NEW.startdate + INTERVAL 7 DAY;
	END IF;
	
END$
DELIMITER ;
