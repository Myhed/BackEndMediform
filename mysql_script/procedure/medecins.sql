DROP PROCEDURE IF EXISTS P_getMedecinById;
DROP PROCEDURE IF EXISTS P_getAllMedecins;

DELIMITER |

    CREATE PROCEDURE P_getMedecinById(IN id_medecin INT)
        BEGIN
            IF (id_medecin IS NULL) THEN
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "PARAMETER MUST NOT BE NULL";
            END IF;
            START TRANSACTION;
                SELECT * FROM `MEDECINS` WHERE `id_medecin` = id_medecin;
            COMMIT;
        END;
    
    CREATE PROCEDURE P_getAllMedecins()
        BEGIN
            START TRANSACTION;
                SELECT * FROM `MEDECINS`;
            COMMIT;
END |