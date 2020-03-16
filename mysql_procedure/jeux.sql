USE esport;

DROP PROCEDURE IF EXISTS getJeuxWithHisCategorie;
DROP PROCEDURE IF EXISTS insertJeux;
DROP FUNCTION IF EXISTS getLastIdJeu;

DELIMITER |
    CREATE PROCEDURE getJeuxWithHisCategorie()
        DETERMINISTIC
        BEGIN
            SELECT `jeux`.`name`,`jeux`.`image_url`,`categorie`.`name`,`jeux`.`id_jeu` FROM `jeux`
            INNER JOIN (`reference`,`categorie`) 
            ON `jeux`.`id_jeu` = `reference`.`id_jeu`
            AND `categorie`.`id_categorie` = `reference`.`id_categorie`;
END|


DELIMITER |
    CREATE PROCEDURE insertJeux (IN p_name VARCHAR(255), IN p_imgUrl VARCHAR(255), IN p_nameCategorie VARCHAR(255))
    DETERMINISTIC
        BEGIN

        DECLARE catid INT DEFAULT NULL;
        DECLARE lastInsertJeu INT DEFAULT NULL;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        IF (p_nameCategorie IS NULL OR p_nameCategorie = "") THEN
            SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 10010, MESSAGE_TEXT = "INVALID CATEGORIE NAME";
        END IF;

        START TRANSACTION;
            INSERT INTO jeux(`name`,`image_url`) VALUES(p_name, p_imgUrl);

            SET lastInsertJeu = LAST_INSERT_ID();
            SET catid = getCategorieByName(p_nameCategorie);

            IF (catid IS NULL) THEN
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "NOT FOUND resource with this name";
            ELSE
                INSERT INTO reference(`id_categorie`,`id_jeu`) VALUES(catid,lastInsertJeu);
            END IF;
        COMMIT;
END|

DELIMITER $$
        CREATE FUNCTION getLastIdJeu()
        RETURNS INT
        NOT DETERMINISTIC
        BEGIN
            DECLARE id INT DEFAULT NULL;

            SELECT id_jeu INTO id FROM jeux ORDER BY id_jeu DESC LIMIT 1;

            RETURN id;
        RETURN id;
END $$