
-- PREND TOUT LES PATIENT AFFILE à un mdecin précis

SELECT `MEDECINS`.`nom`,`MEDECINS`.`prenom`,`MEDECINS`.`profession`,
`PATIENTS`.`nom` AS `nomPatient`,`PATIENTS`.`prenom` AS `prenomPatient` 
FROM `MEDECINS` INNER JOIN (`AFFILE`, `PATIENTS`) 
ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
WHERE `MEDECINS`.`id_medecin` = 1; -- le 1 est la variable --



-- PRENDRE TOUT LES RDV d'un medecins 

SELECT `MEDECINS`.`nom`,`MEDECINS`.`prenom`,`MEDECINS`.`profession`,
`PATIENTS`.`nom` AS `nomPatient`,`PATIENTS`.`prenom` AS `prenomPatient`
`PREND`.`dateRdv`,`RDV`.`sujetConsultation`,`RDV`.`typeConsultation` 
FROM `MEDECINS` INNER JOIN (`AFFILE`, `PATIENTS`) 
ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
INNER JOIN (`RDV`, `PREND`)
ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
WHERE `AFFILE`.`dateAffiliation` = `PREND`.`dateRdv`
AND `MEDECINS`.`id_medecin` = 1; -- le 1 est la variable --

-- PRENDRE TOUT LES RDV d'aujourd'hui d'un medecin

SELECT `MEDECINS`.`nom`,`MEDECINS`.`prenom`,`MEDECINS`.`profession`,
`PATIENTS`.`nom` AS `nomPatient`,`PATIENTS`.`prenom` AS `prenomPatient`,
`PREND`.`dateRdv`,`RDV`.`sujetConsultation`,`RDV`.`typeConsultation` 
FROM `MEDECINS` INNER JOIN (`AFFILE`, `PATIENTS`) 
ON `MEDECINS`.`id_medecin` = `AFFILE`.`id_medecin`
AND `PATIENTS`.`id_patient` = `AFFILE`.`id_patient`
INNER JOIN (`RDV`, `PREND`)
ON `RDV`.`id_rdv` = `PREND`.`id_rdv`
AND `PATIENTS`.`id_patient` = `PREND`.`id_patient`
WHERE `PREND`.`dateRdv` = NOW()
AND `MEDECINS`.`id_medecin` = 1;