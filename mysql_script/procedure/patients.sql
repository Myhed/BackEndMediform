DROP PROCEDURE IF EXISTS P_getPatientById;
DROP PROCEDURE IF EXISTS P_getAllPatients;
DROP PROCEDURE IF EXISTS P_insertPatient;
DROP PROCEDURE IF EXISTS P_loginPatient;
DROP PROCEDURE IF EXISTS P_verifyLoginByMac;

DELIMITER |

    CREATE PROCEDURE P_getPatientById(IN id_patient INT)
        BEGIN
            IF (id_patient IS NULL) THEN
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "PARAMETER MUST NOT BE NULL";
            END IF;
            START TRANSACTION;
                SELECT * FROM `PATIENTS` WHERE `PATIENTS`.`id_patient` = id_patient;
            COMMIT;
        END;
    
    CREATE PROCEDURE P_getAllPatients()
        DETERMINISTIC
        LANGUAGE SQL
        READS SQL DATA
        BEGIN
            START TRANSACTION;
                SELECT * FROM `PATIENTS`;
            COMMIT;
    END;

    CREATE PROCEDURE P_insertPatient(
        IN nom VARCHAR(255), 
        IN prenom VARCHAR(255), 
        IN ville VARCHAR(255), 
        IN tel VARCHAR(255), 
        IN adresse VARCHAR(255),
        IN dateNaissance DATE, 
        IN email VARCHAR(255))
        DETERMINISTIC
        BEGIN
        DECLARE lastInsertPatient INT DEFAULT NULL;
        DECLARE keyConnexion_login BLOB DEFAULT NULL;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                RESIGNAL;
            END;
        START TRANSACTION;
          IF(
              (ville is NULL)  AND 
              (prenom is NULL) AND 
              (nom is NULL)    AND
              (tel is NULL)    AND 
              (adresse is NULL) AND
              (email is NULL) AND
              (dateNaissance is NULL)
              ) THEN
              SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20020, MESSAGE_TEXT = "PARAMS MUST NOT BE NULL";
          ELSE
            IF (nom = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "nom MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(prenom = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "prenom MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(ville = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "ville MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(tel = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "tel MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(adresse = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "adresse MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(dateNaissance = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "dateNaissance MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(email = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "email MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
          END IF;
          INSERT INTO `PATIENTS` (`id_patient`,`nom`,`prenom`,`ville`,`tel`,`email`,`adresse`,`dateNaissance`) 
          VALUES(null, nom, prenom, ville, tel, email, adresse, dateNaissance);
          SET lastInsertPatient = LAST_INSERT_ID();
          SET keyConnexion_login = F_createToken(16);
          SELECT keyConnexion_login;
          INSERT INTO `LOGIN_PATIENT` (`id_login`,`id_patient`,`keyConnexion`)
          VALUES(null,lastInsertPatient,keyConnexion_login);
        COMMIT;
    END;

CREATE PROCEDURE P_loginPatient(IN email VARCHAR(255))
    DETERMINISTIC
    LANGUAGE SQL
    READS SQL DATA
    BEGIN
      DECLARE id_patient INT DEFAULT NULL;
      DECLARE tokenPatient VARBINARY(512) DEFAULT NULL;
      DECLARE macPatient VARBINARY(512) DEFAULT NULL;
        SET id_patient = F_getidByEmailPatient(email);
        SET tokenPatient = F_getTokenByIdPatient(id_patient);
        SET macPatient = HEX(F_xorKey(tokenPatient,42));
        SELECT macPatient;
    END;
CREATE PROCEDURE P_verifyLoginByMac(IN mac VARCHAR(255))
    DETERMINISTIC
    LANGUAGE SQL
    BEGIN
    DECLARE tokenPatientGiven VARBINARY(512) DEFAULT NULL;
    DECLARE macPatientGiven VARBINARY(512) DEFAULT NULL;
    DECLARE tokenPatient VARBINARY(512) DEFAULT NULL;

    SET macPatientGiven = UNHEX(mac);
    SET tokenPatientGiven = F_xorKey(macPatientGiven,42);

    SELECT `keyConnexion` INTO tokenPatient FROM `LOGIN_PATIENT` WHERE `keyConnexion` = tokenPatientGiven;
    IF(tokenPatient = tokenPatientGiven) THEN
        SELECT 1 as `auth`;
    ELSE
        SELECT 0 as `auth`;
    END IF;
END |