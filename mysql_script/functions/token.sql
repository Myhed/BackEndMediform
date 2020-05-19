DROP FUNCTION IF EXISTS F_createToken;
DROP FUNCTION IF EXISTS F_xorKey;
DROP FUNCTION IF EXISTS F_tokenFromMac;
DROP FUNCTION IF EXISTS F_verifyToken;

DELIMITER |

    CREATE FUNCTION F_createToken(sizeOfToken SMALLINT UNSIGNED)
        RETURNS VARBINARY(512)
        NOT DETERMINISTIC
        BEGIN
         DECLARE token VARBINARY(512) DEFAULT "";
         IF(512 < sizeOfToken) THEN
          SET sizeOfToken = 512;
          END IF;
         createToken: LOOP
            SET token = CONCAT(token, UNHEX(LPAD(HEX(FLOOR(RAND()*(255 - 0 + 1)) + 0), 2, 0)));
            IF(LENGTH(token) < sizeOfToken) THEN ITERATE createToken; END IF;
            LEAVE createToken;
         END LOOP createToken;
         RETURN token;
    END;
    CREATE FUNCTION F_xorKey(token VARBINARY(16),In_key TINYINT UNSIGNED)
        RETURNS VARBINARY(16)
        NOT DETERMINISTIC
        BEGIN
          DECLARE mac VARBINARY(16) DEFAULT "";
          DECLARE triggerLoop INT DEFAULT 1;
        --   SELECT LENGTH(token) AS 'tokenLength', token AS 'TokenValue';
          generateMac: LOOP
           SET mac = CONCAT(mac,UNHEX(LPAD(HEX(CONV(HEX(SUBSTR(token,triggerLoop,1)),16,10) ^ In_key),2,0)));
        --    SELECT CONCAT(mac,HEX(SUBSTR(token,triggerLoop,2))) ^ 42 AS 'value', LENGTH(SUBSTR(token,triggerLoop,2));
           SET triggerLoop = triggerLoop + 1;
           IF(triggerLoop <= LENGTH(token)) THEN ITERATE generateMac; END IF;
           LEAVE generateMac;
          END LOOP generateMac;
          RETURN mac;
    END;

    CREATE FUNCTION F_verifyToken(token VARBINARY(16), mac VARBINARY(16))
      RETURNS INT
      DETERMINISTIC
      LANGUAGE SQL
      CONTAINS SQL
      BEGIN
      IF (token is NOT NULL AND mac is NOT NULL) THEN
        IF (token = F_xorKey(mac,42)) THEN
          RETURN 1;
        ELSE
          RETURN 0;
        END IF;
      END IF;
END |