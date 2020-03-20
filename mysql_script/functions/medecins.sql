DROP FUNCTION IF EXISTS F_getMedecinById;
DROP FUNCTION IF EXISTS F_getIdMedecinByHisProfession;
DROP FUNCTION IF EXISTS F_getDateMedecinSmaller;

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
    CREATE FUNCTION F_getIdMedecinByHisProfession(profession VARCHAR(255))
      RETURNS INT
      NOT DETERMINISTIC
      BEGIN
        DECLARE countNumberColumnMatched INT DEFAULT NULL;
        DECLARE idMedecinAvailable INT DEFAULT 0;
        DECLARE idMedecin INT DEFAULT 0;
        DECLARE lastDateAffiliation DATETIME DEFAULT NULL;
        DECLARE verifyDateIsExceedValue BOOLEAN DEFAULT NULL;
        DECLARE cursorLoop INT DEFAULT 0;
        DECLARE cursorLoop2 INT DEFAULT 0;

        DECLARE idMedecinLoop1 INT DEFAULT NULL;
        DECLARE idMedecinLoop2 INT DEFAULT NULL;
        DECLARE idMedecinDateSmaller INT DEFAULT NULL;
        -- On compte le nombre de medecin récupérer dans une profession
        SELECT COUNT(`MEDECINS`.`id_medecin`) INTO countNumberColumnMatched FROM `MEDECINS` 
        WHERE `MEDECINS`.`profession` = profession;
        -- Si on trouve 1 ou plusieurs entré alors on va vers la boucle
        IF (countNumberColumnMatched >= 1) THEN
          searchMedecinAvailable: LOOP
            -- A chaque tour de la loup on récupére un id d'un medecin
            SELECT `MEDECINS`.`id_medecin` INTO idMedecinAvailable FROM `MEDECINS` 
            WHERE`MEDECINS`.`profession` = profession
            ORDER BY `MEDECINS`.`id_medecin` ASC LIMIT cursorLoop,1;

            SET cursorLoop = cursorLoop + 1;
            -- On récupére la dernière de son dernier rendez-vous
            SET lastDateAffiliation = F_getLastAffiliationMedecinToday(idMedecinAvailable);
            -- On verifie si la date de son dernier rendez vous et inférieur à la date d'aujourd'hui
            SET verifyDateIsExceedValue = F_verifyDateIsExceed(lastDateAffiliation);
            -- La fonction renvoi true alors ce medecin est disponible
            IF(verifyDateIsExceedValue = true) THEN
              -- On stock l'id du medecin disponible
              SET idMedecin = idMedecinAvailable;
              -- Et on quitte la boucle
              LEAVE searchMedecinAvailable;
            ELSE
              -- Autrement aucun medecin n'est disponible pour le moment et SET la variable à 0
              SET idMedecinAvailable = 0;
            END IF;
            IF (cursorLoop < countNumberColumnMatched) THEN
                ITERATE searchMedecinAvailable;
            ELSE
            -- une fois la boucle terminer on stock la valeur de l'id du medecin 
            SET idMedecin = idMedecinAvailable;
            -- On reset le cursorLoop pour une prochaine boucle
            SET cursorLoop = 0;
            -- Puis on quitte la boucle
            LEAVE searchMedecinAvailable;
            END IF;
          END LOOP searchMedecinAvailable;
        END IF;
        -- Si on a pas trouver de medecin disponible alors faudra cette fois-ci assigner le rendez-vous à un medecin
        -- Qui finira plutôt que les autres
        IF (idMedecinAvailable = 0) THEN
          searchMedecinIsSoonAvailable: LOOP
          -- On boucle on prend l'id d'un medecin exemple cursorLoop = 0
          SELECT `MEDECINS`.`id_medecin` INTO idMedecinLoop1 FROM `MEDECINS` 
          WHERE`MEDECINS`.`profession` = profession
          ORDER BY `MEDECINS`.`id_medecin` ASC LIMIT cursorLoop,1;
          -- On increment le cursor pour la boucle
          SET cursorLoop = cursorLoop + 1;
          -- On va passer au moins une fois dans le IF pour avoir au moins deux valeur cursorLoop = 1
          IF(cursorLoop = 1) THEN
           -- Notre deuxième medecin
            SELECT `MEDECINS`.`id_medecin` INTO idMedecinLoop2 FROM `MEDECINS` 
            WHERE`MEDECINS`.`profession` = profession
            ORDER BY `MEDECINS`.`id_medecin` ASC LIMIT cursorLoop2,1;
            -- On récupère l'id du medecin qui a la plus petite date
            SET idMedecinDateSmaller = F_getDateMedecinSmaller(idMedecinLoop1,idMedecinLoop2); 
          ELSE
            -- Une fois la cursorLoop dépasser 1 nous avons un idMedecinDateSmaller qui repasse dans la fonction
            -- getDateMedecinSmaller avec une autre date qui est idMedecinLoop1
            SET idMedecinDateSmaller = F_getDateMedecinSmaller(idMedecinLoop1,idMedecinDateSmaller);
          END IF;
          
          IF(cursorLoop < countNumberColumnMatched) THEN
            ITERATE searchMedecinIsSoonAvailable;
          ELSE
            SET idMedecin = idMedecinDateSmaller;
            LEAVE searchMedecinIsSoonAvailable;
          END IF;
         END LOOP searchMedecinIsSoonAvailable;
        END IF;
        RETURN idMedecin;
END |