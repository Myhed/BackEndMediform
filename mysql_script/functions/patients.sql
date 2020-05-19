DROP FUNCTION IF EXISTS F_checkPatientIsInRdv;
DROP FUNCTION IF EXISTS F_getIdByEmailPatient;
DROP FUNCTION IF EXISTS F_getTokenByIdPatient;

DELIMITER |
CREATE FUNCTION F_getIdByEmailPatient(email VARCHAR(255))
    RETURNS INT
    DETERMINISTIC
    LANGUAGE SQL
    READS SQL DATA
    BEGIN
      DECLARE idPatient INT DEFAULT NULL;
      SELECT `id_patient` INTO idPatient FROM `PATIENTS` WHERE `email` = email ORDER BY id_patient DESC LIMIT 1;
      RETURN idPatient;

  END;
CREATE FUNCTION F_getTokenByIdPatient(id INT)
    RETURNS VARBINARY(512)
    DETERMINISTIC
    LANGUAGE SQL
    READS SQL DATA
    BEGIN
      DECLARE tokenPatient VARBINARY(512) DEFAULT NULL;
      SELECT `keyConnexion` INTO tokenPatient FROM `LOGIN_PATIENT` WHERE `id_patient` = id;
      RETURN tokenPatient;

END |