DROP FUNCTION IF EXISTS F_getMedecinById;

DELIMITER |
    CREATE FUNCTION F_getMedecinById(id_medecin INT)
      RETURNS JSON
      NO SQL
      DETERMINISTIC
        BEGIN
          DECLARE resultRequest JSON DEFAULT NULL;
          SELECT * INTO resultRequest FROM `MEDECINS` WHERE `id_medecin` = id_medecin;

          RETURN resultRequest;
          
END |