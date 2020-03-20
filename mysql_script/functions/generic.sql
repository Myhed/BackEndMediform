DROP FUNCTION IF EXISTS F_verifyDateIsExceed;

DELIMITER |
CREATE FUNCTION F_verifyDateIsExceed(dateValue DATETIME)
      RETURNS BOOLEAN
      NOT DETERMINISTIC
      BEGIN
        DECLARE isExceedDate BOOLEAN DEFAULT false;
        DECLARE dateValueWithoutSecond DATETIME DEFAULT NULL;
        DECLARE dateTodayWithoutSecond DATETIME DEFAULT NULL;

        SET dateValueWithoutSecond = DATE_FORMAT(dateValue, '%Y-%m-%d %H:%i');
        SET dateTodayWithoutSecond = DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i');

        IF(dateTodayWithoutSecond > dateValueWithoutSecond) THEN
            SET isExceedDate = true;
        END IF;
        RETURN isExceedDate;
END |