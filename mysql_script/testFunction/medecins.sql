DROP PROCEDURE IF EXISTS PTest_getIdMedecinAvailableByHisProfession;
DELIMITER |
CREATE PROCEDURE PTest_getIdMedecinAvailableByHisProfession(profession VARCHAR(255))
      NOT DETERMINISTIC
      BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE idMedecin INT DEFAULT NULL;
        DECLARE OldIdMedecin INT DEFAULT NULL;
        DECLARE isExceed INT DEFAULT 0;
        DECLARE lastRdvMedecin BIGINT DEFAULT NULL;
        DECLARE getMedecinCursor CURSOR(MedecinProfession VARCHAR(255)) FOR SELECT `id_medecin` FROM `MEDECINS` WHERE `MEDECINS`.`profession` = MedecinProfession;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

        OPEN getMedecinCursor(profession);

        searchAvailableMedecin: LOOP
          FETCH getMedecinCursor INTO idMedecin;
          SET lastRdvMedecin = F_getLastAffiliationMedecinToday(idMedecin);
          IF(lastRdvMedecin is NULL) THEN
            LEAVE searchAvailableMedecin;
          END IF;

          SET isExceed = F_verifyDateIsExceed(lastRdvMedecin);
          SELECT isExceed;
          IF (isExceed) THEN
            LEAVE searchAvailableMedecin;
          ELSE
            IF(OldIdMedecin) THEN
              SELECT F_fromUnixTimestampDate(F_getLastAffiliationMedecinToday(OldIdMedecin));
              SELECT F_fromUnixTimestampDate(F_getLastAffiliationMedecinToday(idMedecin));
              IF(F_fromUnixTimestampDate(F_getLastAffiliationMedecinToday(OldIdMedecin)) < F_fromUnixTimestampDate(F_getLastAffiliationMedecinToday(idMedecin))) THEN
                SELECT 'HEHO';
                SET idMedecin = OldIdMedecin;
              END IF;
            END IF;
           SET OldIdMedecin = idMedecin;
           SELECT OldIdMedecin;
          END IF;

          IF done THEN
            LEAVE searchAvailableMedecin;
          END IF;
        END LOOP;
        CLOSE getMedecinCursor;
        SELECT idMedecin;
END |