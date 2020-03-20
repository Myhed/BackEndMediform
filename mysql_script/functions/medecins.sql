DROP FUNCTION IF EXISTS F_getMedecinById;
DROP FUNCTION IF EXISTS F_getIdMedecinByHisProfession;

DELIMITER |
    CREATE FUNCTION F_getMedecinById(id_medecin INT)
      RETURNS JSON
      NO SQL
      NOT DETERMINISTIC
        BEGIN
          DECLARE resultRequest JSON DEFAULT NULL;
          SELECT * INTO resultRequest FROM `MEDECINS` WHERE `id_medecin` = id_medecin;
          RETURN resultRequest;
    END;
    CREATE FUNCTION F_getIdMedecinByHisProfession(profession VARCHAR(255))
      RETURNS INT
      NOT DETERMINISTIC
      BEGIN
        DECLARE countNumberColumnMatched INT DEFAULT NULL;
        DECLARE idMedecin INT DEFAULT 0;
        DECLARE lastDateAffiliation DATETIME DEFAULT NULL;
        DECLARE verifyDateIsExceedValue BOOLEAN DEFAULT NULL;
        DECLARE cursorLoop INT DEFAULT 0;

        SELECT COUNT(`MEDECINS`.`id_medecin`) INTO countNumberColumnMatched FROM `MEDECINS` 
        WHERE `MEDECINS`.`profession` = profession;

        IF (countNumberColumnMatched > 1) THEN
          label1: LOOP
            SELECT `MEDECINS`.`id_medecin` INTO idMedecin FROM `MEDECINS` 
            WHERE`MEDECINS`.`profession` = profession
            ORDER BY `MEDECINS`.`id_medecin` ASC LIMIT cursorLoop,1;

            SET cursorLoop = cursorLoop + 1;
            SET lastDateAffiliation = F_getLastAffiliationMedecinToday(idMedecin);
            SET verifyDateIsExceedValue = F_verifyDateIsExceed(lastDateAffiliation);
            IF(verifyDateIsExceedValue = true) THEN
              LEAVE label1;
            END IF;
            IF (cursorLoop < countNumberColumnMatched) THEN
                ITERATE label1;
            END IF;
            LEAVE label1;
          END LOOP label1;
        END IF;
        RETURN idMedecin;
END |