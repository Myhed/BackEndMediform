CREATE DATABASE mediform;
use mediform;

CREATE TABLE PATIENTS(
    id_patient INT(255),
    nom VARCHAR(255) not null,
    prenom VARCHAR(255) not null,
    ville VARCHAR(255) not null,
    profession VARCHAR(255) not null,
    adresse VARCHAR(255) not null,
    dateTimestamp TIMESTAMP null,
    PRIMARY KEY(id_patient)
);

CREATE TABLE MEDECINS(
    id_medecin INT(255),
    nom VARCHAR(255) not null,
    prenom VARCHAR(255) not null,
    ville VARCHAR(255) not null,
    profession VARCHAR(255) not null,
    adresse VARCHAR(255) not null,
    PRIMARY KEY(id_medecin)
);

CREATE TABLE AFFILE(
    id_medecin INT(255),
    id_patient INT(255),
    dateAffiliation DATE not null,
    CONSTRAINT `fk_id_medecin` FOREIGN KEY(`id_medecin`) REFERENCES MEDECINS(`id_medecin`),
    CONSTRAINT `fk_id_patient` FOREIGN KEY(`id_patient`) REFERENCES PATIENTS(`id_patient`),
    PRIMARY KEY(id_medecin,id_patient)
);


CREATE TABLE RDV(
    id_rdv INT(255),
    typeRdv ENUM('consultation','operation') DEFAULT null,
    lieu VARCHAR(255) not null,
    sujetConsultation VARCHAR(255) not null,
    PRIMARY KEY(id_rdv)
);

CREATE TABLE PREND(
    id_rdv INT(255),
    id_patient INT(255),
    dateRdv DATE not null,
    CONSTRAINT `fk_id_rdv_prend` FOREIGN KEY(`id_rdv`) REFERENCES RDV(`id_rdv`),
    CONSTRAINT `fk_id_patient_prend` FOREIGN KEY(`id_patient`) REFERENCES PATIENTS(`id_patient`),
    PRIMARY KEY(id_rdv,id_patient)
);

CREATE TABLE FORMULAIRE(
    id_form INT(255),
    id_rdv INT(255),
    questions TEXT not null,
    CONSTRAINT `fk_id_rdv_form` FOREIGN KEY(`id_rdv`) REFERENCES RDV(`id_rdv`),
    PRIMARY KEY(id_form)
);