DROP DATABASE IF EXISTS mediform;
CREATE DATABASE mediform;
use mediform;

DROP TABLE IF EXISTS PATIENTS;
DROP TABLE IF EXISTS MEDECINS;
DROP TABLE IF EXISTS AFFILE;
DROP TABLE IF EXISTS RDV;
DROP TABLE IF EXISTS PREND;
DROP TABLE IF EXISTS FORMULAIRE;

CREATE TABLE PATIENTS(
    id_patient INT(255) AUTO_INCREMENT,
    nom VARCHAR(255) not null,
    prenom VARCHAR(255) not null,
    ville VARCHAR(255) not null,
    tel VARCHAR(255) not null,
    adresse VARCHAR(255) not null,
    dateTimestamp BIGINT UNSIGNED DEFAULT UNIX_TIMESTAMP(),
    PRIMARY KEY(id_patient)
);

CREATE TABLE MEDECINS(
    id_medecin INT(255) AUTO_INCREMENT,
    nom VARCHAR(255) not null,
    prenom VARCHAR(255) not null,
    ville VARCHAR(255) not null,
    profession VARCHAR(255) not null,
    adresse VARCHAR(255) not null,
    dateTimestamp BIGINT UNSIGNED DEFAULT UNIX_TIMESTAMP(),
    PRIMARY KEY(id_medecin)
);

CREATE TABLE AFFILE(
    id_affiliation INT(255) AUTO_INCREMENT,
    id_medecin INT(255) not null,
    id_patient INT(255) not null,
    dateAffiliation DATETIME not null,
    CONSTRAINT `fk_id_medecin` FOREIGN KEY(`id_medecin`) REFERENCES MEDECINS(`id_medecin`),
    CONSTRAINT `fk_id_patient` FOREIGN KEY(`id_patient`) REFERENCES PATIENTS(`id_patient`),
    PRIMARY KEY(id_affiliation)
);


CREATE TABLE RDV(
    id_rdv INT(255) AUTO_INCREMENT,
    nomHopital VARCHAR(255) not null,
    typeRdv ENUM('consultation','operation') DEFAULT null,
    adresse VARCHAR(255) not null,
    sujetConsultation VARCHAR(255) not null,
    PRIMARY KEY(id_rdv)
);

CREATE TABLE PREND(
    id_rdv INT(255),
    id_patient INT(255),
    dateRdv DATETIME not null,
    CONSTRAINT `fk_id_rdv_prend` FOREIGN KEY(`id_rdv`) REFERENCES RDV(`id_rdv`),
    CONSTRAINT `fk_id_patient_prend` FOREIGN KEY(`id_patient`) REFERENCES PATIENTS(`id_patient`),
    PRIMARY KEY(id_rdv,id_patient)
);

CREATE TABLE FORMULAIRE(
    id_form INT(255) AUTO_INCREMENT,
    id_rdv INT(255),
    questions TEXT not null,
    CONSTRAINT `fk_id_rdv_form` FOREIGN KEY(`id_rdv`) REFERENCES RDV(`id_rdv`),
    PRIMARY KEY(id_form)
);