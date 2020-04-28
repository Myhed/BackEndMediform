DROP FUNCTION IF EXISTS F_getMedecinById;
DROP FUNCTION IF EXISTS F_getIdMedecinAvailableByHisProfession;
DROP FUNCTION IF EXISTS F_getDateMedecinSmaller;
DROP FUNCTION IF EXISTS F_getNotExceededDateMedecin;
DROP FUNCTION IF EXISTS F_insertPatientUser;
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
    CREATE FUNCTION F_getDateMedecinSmaller(id_medecin1 INT, id_medecin2 INT)
      RETURNS INT
      NOT DETERMINISTIC
      BEGIN
        DECLARE dateMedecin1 DATETIME DEFAULT NULL;
        DECLARE dateMedecin2 DATETIME DEFAULT NULL;
        DECLARE idMedecinDateSmaller INT DEFAULT 0;
        
       SET dateMedecin1 = F_getLastAffiliationMedecinToday(id_medecin1);
       SET dateMedecin2 = F_getLastAffiliationMedecinToday(id_medecin2);

       IF(DATE_FORMAT(dateMedecin1, '%H:%i') > DATE_FORMAT(dateMedecin2, '%H:%i')) THEN
          SET idMedecinDateSmaller = id_medecin2;
       ELSE
          SET idMedecinDateSmaller = id_medecin1;
       END IF;
       RETURN idMedecinDateSmaller;
    END;
    CREATE FUNCTION F_getIdMedecinAvailableByHisProfession(profession VARCHAR(255))
      RETURNS INT
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
        -- On cherche un medecin disponible
        searchAvailableMedecin: LOOP
          FETCH getMedecinCursor INTO idMedecin;
          SET lastRdvMedecin = F_getLastAffiliationMedecinToday(idMedecin); -- On recupère le dernier rendez du medecins
          IF(lastRdvMedecin is NULL) THEN
          -- On teste s'il n'a eu aucune affiliation aujourd'hui alors on quitte la boucle on a trouver notre medecin
            LEAVE searchAvailableMedecin;
          END IF;
          -- Sinon on continue et on vérifie si sa dernière affiliation n'est pas dépassé
          SET isExceed = F_verifyDateIsExceed(lastRdvMedecin);
          IF (isExceed) THEN 
            LEAVE searchAvailableMedecin; -- Si la date d'aujourd'hui est dépassé c'est qu'il est libre donc on a notre medecin
          ELSE -- sinon c'est qu'il y'en a aucun de libre et on procède par celui qui est sensé terminer avant les autres
            IF(OldIdMedecin) THEN
              IF(F_fromUnixTimestampDate(F_getLastAffiliationMedecinToday(OldIdMedecin)) < F_fromUnixTimestampDate(F_getLastAffiliationMedecinToday(idMedecin))) THEN
                -- ici on compare donc la date d'affiliation du medecin précédent avec le suivant pour savoir qui est-ce qui va terminer le plutôt
                SET idMedecin = OldIdMedecin;
              END IF;
            END IF;
           SET OldIdMedecin = idMedecin;
          END IF;

          IF done THEN
            LEAVE searchAvailableMedecin;
          END IF;

        END LOOP;
        CLOSE getMedecinCursor;
        RETURN idMedecin;
    END;
    CREATE FUNCTION F_getNotExceededDateMedecin(id_medecin INT)
      RETURNS BIGINT
      DETERMINISTIC
      BEGIN
        DECLARE dateMedecin BIGINT DEFAULT NULL;

        SET dateMedecin = F_getLastAffiliationMedecinToday(id_medecin);

        IF(F_verifyDateIsExceed(dateMedecin)) THEN
          RETURN 0;
        ELSE
          RETURN dateMedecin;
        END IF;
    END;
    CREATE FUNCTION F_insertPatientUser(nom VARCHAR(255), prenom VARCHAR(255), email VARCHAR(255), password VARCHAR(255))
      RETURNS INT
      DETERMINISTIC
      LANGUAGE SQL
      BEGIN
        DECLARE id_patient_insert INT DEFAULT NULL;
        INSERT INTO `PATIENTS` (`id_patient`,`nom`,`prenom`,`ville`,`tel`,`adresse`, `dateNaissance`, `email`, `password`, `confirm`) 
        VALUES(null, nom, prenom, null, null, null, null, email, password);
        
        SET id_patient_insert = LAST_INSERT_ID();

        RETURN id_patient_insert;
END |