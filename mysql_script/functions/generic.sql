DROP FUNCTION IF EXISTS F_verifyDateIsExceed;
DROP FUNCTION IF EXISTS F_fromUnixTimestampDate;
DROP FUNCTION IF EXISTS F_transformDateToUnixTimestamp;
DELIMITER |
CREATE FUNCTION F_verifyDateIsExceed(givenDate BIGINT)
  RETURNS BOOLEAN
  NOT DETERMINISTIC
    BEGIN
      DECLARE isExceedDate BOOLEAN DEFAULT false;
      DECLARE givenDateWithoutSecond DATETIME DEFAULT NULL;
      DECLARE dateTodayWithoutSecond DATETIME DEFAULT NULL;

      SET givenDateWithoutSecond = DATE_FORMAT(F_FromUnixTimestampDate(givenDate), '%Y-%m-%d %H:%i');
      SET dateTodayWithoutSecond = DATE_FORMAT(F_FromUnixTimestampDate(UNIX_TIMESTAMP()), '%Y-%m-%d %H:%i');

      IF(dateTodayWithoutSecond > givenDateWithoutSecond) THEN
        SET isExceedDate = true;
      END IF;
      RETURN isExceedDate;
END;
CREATE FUNCTION F_fromUnixTimestampDate(unixTimestamp BIGINT)
  RETURNS DATETIME
  DETERMINISTIC
  BEGIN
    RETURN DATE_FORMAT(FROM_UNIXTIME(unixTimestamp),'%Y-%m-%d %H:%i:%s');
END;
CREATE FUNCTION F_transformDateToUnixTimestamp(givenDate DATETIME)
  RETURNS BIGINT
  DETERMINISTIC
  BEGIN
    RETURN UNIX_TIMESTAMP(givenDate);
END |