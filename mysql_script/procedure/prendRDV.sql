-- SELECT ADDTIME(NOW(),3 * 1000); -- 10 étant le paramètre * 1000 donne 30 minutes

-- On ne peut pas prendre deux rendez vous à la même heure visant un même medcins donc on ajoute 30minute à l'heure du RDV si ce même medecin à un rendez-vous
-- à cette instant précis

-- première il faudrait récupérer la date du dernier rendez-vous pris du medecins, on compare la date de prise du RDV avec la date de maintenant on devrait
-- obtenir la différence des deux et si celle-ci et est inférieur alors on enlève de par cette différence à la durée maximum d'une consultation exemple
-- duré consultation le medecin à renseigner 30 alors  tempsConsultationPasser = datePriseRDV - DateNOW
-- donc duréConsultation - tempsConsultation 
