-- SELECT ADDTIME(NOW(),3 * 1000); -- 3 étant le paramètre * 1000 donne 30 minutes

-- On ne peut pas prendre deux rendez vous à la même heure visant un même medcins donc on ajoute 30minute à l'heure du RDV si ce même medecin à un rendez-vous
-- à cette instant précis

-- première il faudrait récupérer la date du dernier rendez-vous pris du medecins, on compare la date de prise du RDV avec la date de maintenant on devrait
-- obtenir la différence des deux et si celle-ci et est inférieur alors on enlève de par cette différence à la durée maximum d'une consultation exemple
-- duré consultation le medecin à renseigner 30 alors  tempsConsultationPasser = datePriseRDV - DateNOW
-- donc duréConsultation - tempsConsultation

-- ADDTIME('2020-03-18 00:00:00', +6000 * 40) donne 2020-03-19 00:00:00 

DROP PROCEDURE IF EXISTS P_getAllRdv;
DROP PROCEDURE IF EXISTS P_getAllRdvToday;
DROP PROCEDURE IF EXISTS P_getRdvMedecinById;
DROP PROCEDURE IF EXISTS P_getRdvMedecinTodayById;
DROP PROCEDURE IF EXISTS P_getRdvPatient;
DROP PROCEDURE IF EXISTS P_getRdvPatientById;
DROP PROCEDURE IF EXISTS getDateLastRdvMedecin;
DROP PROCEDURE IF EXISTS insertRdv;

DELIMITER |
    -- get ALL RDV
    CREATE PROCEDURE P_getAllRdv()
        DETERMINISTIC
        BEGIN
            START TRANSACTION;
                SELECT `RDV`.`sujetConsultation`,`RDV`.`typeRdv`,`PREND`.`dateRdv`,
                `PATIENTS`.`nom` AS `nomPatient`,`PATIENTS`.`prenom` AS `prenomPatient`,
                `MEDECINS`.`nom`AS `nomMedecin`,`MEDECINS`.`prenom` AS `prenomMedecin` 
                FROM `RDV` INNER JOIN (`PREND`,`PATIENTS`)
                ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
                AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
                INNER JOIN (`MEDECINS`,`AFFILE`)
                ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
                AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
                WHERE `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`;
            COMMIT;
    END;
    CREATE PROCEDURE P_getAllRdvToday()
        DETERMINISTIC
        BEGIN
            START TRANSACTION;
                SELECT `RDV`.`sujetConsultation`,`RDV`.`typeRdv`,`PREND`.`dateRdv`,
                `PATIENTS`.`nom` AS `nomPatient`,`PATIENTS`.`prenom` AS `prenomPatient`,
                `MEDECINS`.`nom`AS `nomMedecin`,`MEDECINS`.`prenom` AS `prenomMedecin` 
                FROM `RDV` INNER JOIN (`PREND`,`PATIENTS`)
                ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
                AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
                INNER JOIN (`MEDECINS`,`AFFILE`)
                ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
                AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
                AND `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`
                WHERE DATE(`PREND`.`dateRdv`) = CURRENT_DATE();
            COMMIT;
    END;
    CREATE PROCEDURE P_getRdvMedecinById(IN id_medecin INT)
        NOT DETERMINISTIC
        BEGIN 
          IF(id_medecin IS NULL) THEN
            SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "id_medecin must not be NULL";
          END IF;

          START TRANSACTION;  
            SELECT `RDV`.`sujetConsultation`,`RDV`.`typeRdv`,`PREND`.`dateRdv`,
            `PATIENTS`.`nom`,`PATIENTS`.`prenom`
            FROM `RDV` INNER JOIN (`PREND`,`PATIENTS`)
            ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
            AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
            INNER JOIN (`MEDECINS`,`AFFILE`)
            ON `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
            AND `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`
            WHERE`MEDECINS`.`id_medecin` = id_medecin;
          COMMIT;
    END;
    CREATE PROCEDURE P_getRdvMedecinTodayById(IN id_medecin INT)
        NOT DETERMINISTIC
        BEGIN 
          IF(id_medecin IS NULL) THEN
            SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "id_medecin must not be NULL";
          END IF;

          START TRANSACTION;  
            SELECT `RDV`.`sujetConsultation`,`RDV`.`typeRdv`,`PREND`.`dateRdv`,
            `PATIENTS`.`nom`,`PATIENTS`.`prenom`
            FROM `RDV` INNER JOIN (`PREND`,`PATIENTS`)
            ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
            AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
            INNER JOIN (`MEDECINS`,`AFFILE`)
            ON  `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
            AND `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`
            WHERE `MEDECINS`.`id_medecin` = id_medecin
            AND DATE(`PREND`.`dateRDV`) = CURRENT_DATE();
          COMMIT;
    END;
        
    CREATE PROCEDURE P_getRdvPatientById(IN id_patient INT)
        LANGUAGE SQL
        READS SQL DATA
        DETERMINISTIC
        BEGIN 
          IF(id_patient IS NULL) THEN
            SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "id_patient must not be NULL"; 
          END IF;

          START TRANSACTION;  
            SELECT `RDV`.`sujetConsultation`,DATE_FORMAT(`PREND`.`dateRdv`,'%Y-%m-%d %H:%i'),`MEDECINS`.`nom`,`MEDECINS`.`prenom`
            FROM `RDV` INNER JOIN(`PREND`,`PATIENTS`)
            ON `PREND`.`id_rdv` = `RDV`.`id_rdv`
            AND `PREND`.`id_patient` = `PATIENTS`.`id_patient`
            INNER JOIN(`AFFILE`,`MEDECINS`)
            ON `AFFILE`.`id_medecin` = `MEDECINS`.`id_medecin`
            AND `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`
            WHERE `PATIENTS`.`id_patient` = 1
            AND DATE(`AFFILE`.`dateAffiliation`) >= CURRENT_DATE();
          COMMIT;
    END;
    -- les tables concernet MEDECINS  ====> AFFILE <===== PATIENTS ====> PREND <===== RDV
    CREATE PROCEDURE insertRdv(
      IN id_patient INT,
      IN nomHopital VARCHAR(255),
      IN typeRdv VARCHAR(255),
      IN adresse VARCHAR(255),
      IN sujetConsultation VARCHAR(255),
      IN serviceHopital VARCHAR(255)
    )
        DETERMINISTIC
        BEGIN
          DECLARE lastInsertIdRdv INT DEFAULT NULL;
          DECLARE idMedecin INT DEFAULT NULL;
          DECLARE dateRdv BIGINT DEFAULT NULL;
          DECLARE dateFinAffiliation BIGINT DEFAULT NULL;
          DECLARE x BIGINT DEFAULT NULL;

          SET idMedecin = F_getIdMedecinAvailableByHisProfession(serviceHopital);

          SET dateRdv = F_transformDateToUnixTimestamp(NOW());
          SET dateFinAffiliation = F_transformDateToUnixTimestamp(ADDTIME(NOW(),1.5 * 1000));
          IF(F_getNotExceededDateMedecin(idMedecin)) THEN
            SET x = F_getNotExceededDateMedecin(idMedecin);
            SET dateRdv = x;
            SELECT dateRdv;
            SET dateFinAffiliation = F_transformDateToUnixTimestamp(ADDTIME(F_fromUnixTimestampDate(x),1.5 * 1000));
            SELECT dateFinAffiliation;
          END IF;

          START TRANSACTION;
            INSERT INTO `RDV` (`id_rdv`,`nomHopital`,`typeRdv`,`adresse`,`sujetConsultation`)
            VALUES(null,nomHopital,typeRdv,adresse,sujetConsultation);
            SET lastInsertIdRdv = LAST_INSERT_ID();
            INSERT INTO `PREND` (`id_rdv`,`id_patient`,`dateRdv`)
            VALUES(lastInsertIdRdv,id_patient,dateRdv);

            INSERT INTO `AFFILE` (`id_affiliation`,`id_medecin`,`id_patient`,`dateAffiliation`,`dateFinAffiliation`)
            VALUES(null,idMedecin,id_patient,dateRdv,dateFinAffiliation);
          COMMIT;
          SELECT idMedecin;
END |
