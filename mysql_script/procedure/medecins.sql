DROP PROCEDURE IF EXISTS P_getMedecinById;
DROP PROCEDURE IF EXISTS P_getAllMedecins;
DROP PROCEDURE IF EXISTS P_insertMedecin;
DROP PROCEDURE IF EXISTS P_verifyIsStillInRdv;
DELIMITER |

    CREATE PROCEDURE P_getMedecinById(IN id_medecin INT)
        BEGIN

            IF (id_medecin IS NULL) THEN
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "PARAMETER MUST NOT BE NULL";
            END IF;
            SELECT * FROM `MEDECINS` WHERE `MEDECINS`.`id_medecin` = id_medecin;
        END;
    
    CREATE PROCEDURE P_getAllMedecins()
        BEGIN
            START TRANSACTION;
                SELECT * FROM `MEDECINS`;
            COMMIT;
        END;

    CREATE PROCEDURE P_insertMedecin(IN nom VARCHAR(255), IN prenom VARCHAR(255), IN ville VARCHAR(255), IN profession VARCHAR(255), IN adresse VARCHAR(255))
        DETERMINISTIC
        BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                RESIGNAL;
            END;
        
        START TRANSACTION;
          IF(
              (ville is NULL)      AND 
              (prenom is NULL)     AND 
              (nom is NULL)        AND
              (profession is NULL) AND 
              (adresse is NULL)
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
            IF(profession = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "profession MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
            IF(adresse = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "adresse MUST BE VARCHAR TYPE AND NOT EMPTY";
            END IF;
          END IF;
          INSERT INTO `MEDECINS` (`id_medecin`,`nom`,`prenom`,`ville`,`profession`,`adresse`) VALUES(null, nom, prenom, ville, profession, adresse);
        COMMIT;
    END;
    CREATE PROCEDURE P_verifyIsStillInRdv(IN dateAffiliation DATETIME)
      DETERMINISTIC
      BEGIN
        DECLARE isInRdv BOOLEAN DEFAULT NULL;
         IF (dateAffiliation IS NULL OR dateAffiliation = "") THEN
          SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "INVALIDE PARAMETER NEED TO GIVE REAL VALUE DATE LIKE DATE,DATETIME TYPE";
        END IF;
        SET isInRdv = F_verifyDateIsExceed(dateAffiliation);
        SELECT isInRdv;
        
END |