DROP PROCEDURE IF EXISTS P_getMedecinById;
DROP PROCEDURE IF EXISTS P_getAllMedecins;
DROP PROCEDURE IF EXISTS P_insertMedecin;
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
              (ville is NULL OR ville = "")   AND 
              (prenom is NULL OR prenom = "") AND 
              (nom is NULL OR nom = "")       AND
              (profession is NULL OR profession = "") AND 
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
            IF(profession is NULL OR profession = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "profession MUST BE VARCHAR TYPE";
            END IF;
            IF(adresse is NULL OR adresse = "") THEN
             SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "adresse MUST BE VARCHAR TYPE";
            END IF;
          END IF;

          INSERT INTO `MEDECINS` (`id_medecin`,`nom`,`prenom`,`ville`,`profession`,`adresse`) VALUES(null, nom, prenom, ville, profession, adresse);
        COMMIT;
END |