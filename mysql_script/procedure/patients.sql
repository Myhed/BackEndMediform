DROP PROCEDURE IF EXISTS P_getPatientById;
DROP PROCEDURE IF EXISTS P_getAllPatients;

DELIMITER |

    CREATE PROCEDURE P_getPatientById(IN id_patient INT)
        BEGIN
            IF (id_patient IS NULL) THEN
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "PARAMETER MUST NOT BE NULL";
            END IF;
            START TRANSACTION;
                SELECT * FROM `PATIENTS` WHERE `id_patient` = id_patient;
            COMMIT;
        END;
    
    CREATE PROCEDURE P_getAllPatients()
        BEGIN
            START TRANSACTION;
                SELECT * FROM `PATIENTS`;
            COMMIT;
END |