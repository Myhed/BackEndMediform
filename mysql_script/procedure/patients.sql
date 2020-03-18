DROP PROCEDURE IF EXISTS P_getPatientById;
DROP PROCEDURE IF EXISTS P_getAllPatients;
DROP PROCEDURE IF EXISTS P_insertPatient;

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
        BEGIN
            START TRANSACTION;
                SELECT * FROM `PATIENTS`;
            COMMIT;
    END;

    CREATE PROCEDURE P_insertPatient(IN nom VARCHAR(255), IN prenom VARCHAR(255), IN ville VARCHAR(255), IN tel VARCHAR(255), IN adresse VARCHAR(255))
        DETERMINISTIC
        BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                RESIGNAL;
            END;
        START TRANSACTION;
          IF(
              (ville is NULL OR ville = "")   AND 
              (prenom is NULL OR prenom = "") AND 
              (nom is NULL OR nom = "")       AND
              (tel is NULL OR tel = "")       AND 
              (adresse is NULL OR adresse = "")
              ) THEN
              SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20020, MESSAGE_TEXT = "ALL PARAMS IS INVALIDE";
          ELSE
            IF (nom is NULL OR nom = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "nom MUST BE VARCHAR TYPE";
            END IF;
            IF(prenom is NULL OR prenom = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "prenom MUST BE VARCHAR TYPE";
            END IF;
            IF(ville is NULL OR ville = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "ville MUST BE VARCHAR TYPE";
            END IF;
            IF(tel is NULL OR tel = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "tel MUST BE VARCHAR TYPE";
            END IF;
            IF(adresse is NULL OR adresse = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "adresse MUST BE VARCHAR TYPE";
            END IF;
          END IF;

          INSERT INTO `PATIENTS` (`id_patient`,`nom`,`prenom`,`ville`,`tel`,`adresse`) VALUES(null, nom, prenom, ville, tel, adresse);
        COMMIT;

END |