DROP FUNCTION IF EXISTS F_getLastAffiliationMedecinToday;
DELIMITER |

    CREATE FUNCTION F_getLastAffiliationMedecinToday(id_medecin INT)
      RETURNS BIGINT
      NOT DETERMINISTIC
      BEGIN
        DECLARE lastAffiliationToday BIGINT DEFAULT NULL;

        SELECT `AFFILE`.`dateFinAffiliation` INTO lastAffiliationToday 
        FROM `AFFILE` INNER JOIN (`MEDECINS`) 
        ON `AFFILE`.`id_medecin` = `MEDECINS`.`id_medecin`
        WHERE `MEDECINS`.`id_medecin` = id_medecin
        AND DATE(F_fromUnixTimestampDate(`AFFILE`.`dateAffiliation`)) = CURRENT_DATE()
        ORDER BY F_fromUnixTimestampDate(`AFFILE`.`dateAffiliation`) DESC, F_fromUnixTimestampDate(`AFFILE`.`id_affiliation`) LIMIT 1;
        
        RETURN lastAffiliationToday;
END |