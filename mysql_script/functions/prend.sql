DELIMITER |
DROP FUNCTION IF EXISTS getLastRdvPatient(INT id_patient)
SQL LANGUAGE
DETERMINISTIC
    BEGIN
    SELECT
DELIMITER |