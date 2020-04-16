-- SELECT `RDV`.`sujetConsultation`,`RDV`.`typeRdv`,`PREND`.`dateRdv`
-- FROM `RDV` INNER JOIN (`PREND`,`PATIENTS`)
-- ON `PREND`.`id_rdv` = `RDV`.`id_rdv` 
-- AND `PREND`.`id_patient` = `PATIENTS`.`id_patient`
-- WHERE DATE(`PREND`.`dateRdv`) >= CURRENT_DATE()
-- AND `PATIENTS`.`id_patient` = 1

-- SELECT `MEDECINS`.`nom`,`MEDECINS`.`prenom` FROM `MEDECINS`
-- INNER JOIN(`AFFILE`,`PATIENTS`) 
-- ON `AFFILE`.`id_medecin` = `MEDECINS`.`id_medecin`
-- AND `AFFILE`.`id_patient` = `PATIENTS`.`id_patient`
-- WHERE DATE(`AFFILE`.`dateAffiliation`) >= CURRENT_DATE()
-- AND `PATIENTS`.`id_patient` = 1;

SELECT `MEDECINS`.`nom` FROM `MEDECINS`,`PATIENTS` INNER JOIN(`PREND`,`RDV`)
ON `PREND`.`id_patient` = `PATIENTS`.`id_patient`
AND `PREND`.`id_rdv` = `RDV`.`id_rdv`
WHERE `PATIENTS`.`id_patient` = 1