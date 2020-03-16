use esport;
DROP PROCEDURE IF EXISTS insertCategorie;
DROP FUNCTION IF EXISTS getCategorieByName;
DROP FUNCTION IF EXISTS getCategorieById;

DELIMITER |
CREATE PROCEDURE insertCategorie(IN p_nameCategorie VARCHAR(255))
BEGIN
    DECLARE lastInsertCategorie INT;
    DECLARE lastInsertJeu INT;

    IF (p_nameCategorie IS NULL OR p_nameCategorie = "") THEN
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 10010, MESSAGE_TEXT = "INVALID CATEGORIE NAME";
    END IF;

    INSERT INTO categorie(`name`) VALUES(p_nameCategorie);

END |

DELIMITER $$
CREATE FUNCTION getCategorieByName(p_name VARCHAR(255))
    RETURNS INT
    DETERMINISTIC
    BEGIN
        DECLARE catid INT DEFAULT NULL;
        SELECT id_categorie INTO catid FROM categorie WHERE `name` = p_nameCategorie;
        RETURN catid;
END $$

DELIMITER $$
CREATE FUNCTION getCategorieById(p_id INT(255))
    RETURNS INT
    DETERMINISTIC
    BEGIN
        DECLARE cate INT;
        SELECT * INTO cate FROM categorie WHERE `id` = p_id;
        IF (id_categorie IS NULL) THEN
            SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 20010, MESSAGE_TEXT = "NOT FOUND resource with this id";
        END IF;
        RETURN cate;
END $$