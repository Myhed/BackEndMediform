-- SELECT ADDTIME(NOW(),3 * 1000); -- 3 étant le paramètre * 1000 donne 30 minutes

-- On ne peut pas prendre deux rendez vous à la même heure visant un même medcins donc on ajoute 30minute à l'heure du RDV si ce même medecin à un rendez-vous
-- à cette instant précis

-- première il faudrait récupérer la date du dernier rendez-vous pris du medecins, on compare la date de prise du RDV avec la date de maintenant on devrait
-- obtenir la différence des deux et si celle-ci et est inférieur alors on enlève de par cette différence à la durée maximum d'une consultation exemple
-- duré consultation le medecin à renseigner 30 alors  tempsConsultationPasser = datePriseRDV - DateNOW
-- donc duréConsultation - tempsConsultation

DROP PROCEDURE IF EXISTS P_getAllRdv;
DROP PROCEDURE IF EXISTS P_getAllRdvToday;
DROP PROCEDURE IF EXISTS P_getRdvMedecinById;
DROP PROCEDURE IF EXISTS P_getRdvMedecinTodayById;
DROP PROCEDURE IF EXISTS P_getRdvPatient;


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
            ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
            AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
            WHERE `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`
            AND `MEDECINS`.`id_medecin` = id_medecin;
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
            ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
            AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
            WHERE DATE(`RDV`.`dateRDV`) = CURRENT_DATE()
            AND `MEDECINS`.`id_medecin` = id_medecin;
          COMMIT;
        END;
        
    CREATE PROCEDURE P_getRdvPatient(IN id_patient INT)
        NOT DETERMINISTIC
        BEGIN 
          IF(id_patient IS NULL) THEN
            SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "id_patient must not be NULL"; 
          END IF;

          START TRANSACTION;  
            SELECT `RDV`.`sujetConsultation`,`RDV`.`typeRdv`,`PREND`.`dateRdv`,
            `MEDECINS`.`nom`,`MEDECINS`.`prenom` 
            FROM `RDV` INNER JOIN (`PREND`,`PATIENTS`)
            ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
            AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
            INNER JOIN (`MEDECINS`,`AFFILE`)
            ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
            AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
            WHERE `PATIENTS`.`id_patient` = id_patient 
            AND DATE_FORMAT(`AFFILE`.`dateAffiliation`, '%Y-%m-%d %H:%i') = DATE_FORMAT(`PREND`.`dateRdv`, '%Y-%m-%d %H:%i');
          COMMIT;
END |
