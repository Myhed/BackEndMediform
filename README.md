# BackEnd Mediform

## endpoint

There are three endpoints on mediform you can observe it on router folder `patient`,`medecin`,`rdv`

## patient endpoint

 * `GET /patients` => get all patients
 * `GET /patient/:idPatient` => get a specifique patient with id
 * `POST /patient params` **`{nom,prenom,ville,tel,adresse,dateNaissance}`** insert a new patient

 ```sh
[user@user BackEndMediform]$ curl -XPOST -H "Content-Type: application/json" -d '{"nom":"toto","prenom":"titi","ville":"1 rue carambar","tel":"06258569","adresse":"1 rue charle vincent","dateNaissance":"1996-10-31"}' http://localhost:8000/mediform/patient
```

## medecin endpoint

* `GET /medecins`
* `GET /medecin/:idMedecin`
* `POST /medecins params`**`{nom,prenom,ville,profession,adresse}`**

you can make a curl request looks like this

```sh
[user@user BackEndMediform]$ curl -XPOST -H "Content-Type: application/json" -d '{"nom":"toto","prenom":"titi","ville":"1 rue carambar","profession":"medecin generaliste","adresse":"1 rue charle vincent"}' http://localhost:8000/mediform/medecin
```

## rdv endpoint

* `GET /rdvs` <= get all rdv
* `POST /rdv` <= ***not yet implemented***
* `GET /rdv/today` <= get all rdv current day
* `GET /rdv/medecin/:idMedecin` <= get all rdv medecin by id
* `GET /rdv/today/medecin/:idMedecin` <= get all rdv medecin current day by id
* `GET /rdv/patient/:idPatient` <= get all rdv patient by id
