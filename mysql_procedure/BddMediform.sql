DELIMITER |

CREATE PROCEDURE CreateDatabaseMediform()
    DETERMINISTIC
    BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    CREATE DATABASE mediform;
    use mediform;

    START TRANSACTION;
        
    
    END |