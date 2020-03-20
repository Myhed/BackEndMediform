DROP FUNCTION IF EXISTS F_getLastAffiliationMedecinToday;
DELIMITER |

    CREATE FUNCTION F_getLastAffiliationMedecinToday(id_medecin INT)
      RETURNS DATETIME
      NOT DETERMINISTIC
      BEGIN
        DECLARE lastAffiliationToday DATETIME DEFAULT NULL;

        SELECT `AFFILE`.`dateAffiliation` INTO lastAffiliationToday 
        FROM `AFFILE` INNER JOIN (`MEDECINS`) 
        ON `AFFILE`.`id_medecin` = `MEDECINS`.`id_medecin`
        WHERE `MEDECINS`.`id_medecin` = id_medecin
        AND DATE(`AFFILE`.`dateAffiliation`) = CURRENT_DATE()
        ORDER BY `AFFILE`.`dateAffiliation` DESC,`AFFILE`.`id_affiliation` LIMIT 1;
        
        RETURN lastAffiliationToday;
END |