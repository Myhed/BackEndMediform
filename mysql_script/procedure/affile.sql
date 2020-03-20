DROP PROCEDURE IF EXISTS getDateLastAffiliationMedecin;
DELIMITER |

    CREATE PROCEDURE getDateLastAffiliationMedecin(IN id_medecin INT)
      NOT DETERMINISTIC
      BEGIN
        DECLARE lastAffileDate DATETIME DEFAULT NULL;
        SET lastAffileDate = F_getLastAffiliationMedecinToday(id_medecin);
        
        SELECT lastAffileDate;
END |