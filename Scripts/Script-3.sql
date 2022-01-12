-- 
-- DROP TRIGGER IF EXISTS checkEmailForm;
-- 
-- DELIMITER $
-- 
-- CREATE TRIGGER checkEmailForm
-- BEFORE INSERT ON person
-- FOR EACH ROW
-- BEGIN 
-- 	IF (NEW.email IS NOT NULL AND NEW.email NOT LIKE '%_@%_.%_')
-- 		THEN 
-- 			SIGNAL SQLSTATE '45000'
-- 				SET MESSAGE_TEXT = 'WRONG EMAIL';
-- 	END IF;
-- 			
-- END$
-- 
-- DELIMITER ;

-- USE businessregistry;
-- 
-- DROP TRIGGER IF EXISTS checkBusinessTitle;
-- 
-- DELIMITER $
-- 
-- CREATE TRIGGER checkBusinessTitle
-- BEFORE INSERT ON belongs
-- FOR EACH ROW
-- BEGIN 
-- 	DECLARE bTitleCount INT;
-- 
-- 	SELECT	COUNT(*) INTO bTitleCount FROM business b
-- 	INNER JOIN belongs AS bs ON bs.bus_id = b.id
-- 	WHERE NEW.ch_name = bs.ch_name
-- 	AND b.title IN(SELECT title FROM business WHERE id = NEW.bus_id);
-- 
-- 	IF(bTitleCount > 0)
-- 		THEN
-- 			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'TITLE IS NOT UNIQUE';
-- 	END IF;
-- 			
-- END$
-- 
-- DELIMITER ;

-- USE businessregistry;
-- 
-- DROP TRIGGER IF EXISTS checkIfDatesHaveOneWeekDiff;
-- 
-- DELIMITER $
-- 
-- CREATE TRIGGER checkIfDatesHaveOneWeekDiff
-- BEFORE INSERT ON auditor_check
-- FOR EACH ROW
-- BEGIN 
-- 	DECLARE diffDay INT;
-- 	
-- 	SET diffDay = 0;
-- 
-- 	SET diffDay = DATEDIFF(NEW.startdate, NEW.enddate);
-- 
-- 	IF(diffDay < 7)
-- 		THEN
-- 			SET NEW.enddate = NEW.startdate + INTERVAL 7 DAY;
-- 	END IF;
-- 			
-- END$
-- 
-- DELIMITER ;
-- 
-- SELECT * FROM auditor_check;
-- INSERT INTO auditor_check VALUES 
-- (31201,'200000333','2012-12-11 00:00:00','2012-12-13 00:00:01');
