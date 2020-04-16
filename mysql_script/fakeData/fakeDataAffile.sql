INSERT INTO AFFILE (id_medecin, id_patient, dateAffiliation,dateFinAffiliation) VALUES(1,1,UNIX_TIMESTAMP(NOW()),UNIX_TIMESTAMP(ADDTIME(NOW(), 1.5 * 1000)));
INSERT INTO AFFILE (id_medecin, id_patient, dateAffiliation, dateFinAffiliation) VALUES(5,2,UNIX_TIMESTAMP(NOW()),UNIX_TIMESTAMP(ADDTIME(NOW(), 1.5 * 1000)));
INSERT INTO AFFILE (id_medecin, id_patient, dateAffiliation, dateFinAffiliation) VALUES(5,1,UNIX_TIMESTAMP(NOW()), UNIX_TIMESTAMP(ADDTIME(NOW(), 1.5 * 1000)));


-- INSERT INTO AFFILE (id_medecin, id_patient, dateAffiliation) VALUES(2,1,'NOW()');
-- INSERT INTO AFFILE (id_medecin, id_patient, dateAffiliation) VALUES(1,2,'NOW()');