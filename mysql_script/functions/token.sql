DROP FUNCTION IF EXISTS F_createToken;
DROP FUNCTION IF EXISTS F_xorKey;
DROP FUNCTION IF EXISTS F_tokenFromMac;

DELIMITER |

    CREATE FUNCTION F_createToken(sizeOfToken SMALLINT UNSIGNED)
        RETURNS VARBINARY(32)
        NOT DETERMINISTIC
        BEGIN
         DECLARE token VARBINARY(32) DEFAULT "";
         createToken: LOOP
            SET token = CONCAT(token, UNHEX(LPAD(HEX(FLOOR(RAND()*(255 - 0 + 1)) + 0), 2, 0)));
            IF(LENGTH(token) < (sizeOfToken / 2)) THEN ITERATE createToken; END IF;
            LEAVE createToken;
         END LOOP createToken;
         RETURN HEX(token);
    END;
    CREATE FUNCTION F_xorKey(token VARBINARY(16))
        RETURNS VARBINARY(16)
        NOT DETERMINISTIC
        BEGIN
          DECLARE mac VARBINARY(16) DEFAULT "";
          DECLARE triggerLoop INT DEFAULT 1;
        --   SELECT LENGTH(token) AS 'tokenLength', token AS 'TokenValue';
          generateMac: LOOP
           SET mac = CONCAT(mac,LPAD(HEX(CONV(SUBSTR(token,triggerLoop,2),16,10) ^ 42),2,0));
        --    SELECT CONCAT(mac,HEX(SUBSTR(token,triggerLoop,2))) ^ 42 AS 'value', LENGTH(SUBSTR(token,triggerLoop,2));
           SET triggerLoop = triggerLoop + 2;
           IF(triggerLoop <= LENGTH(token)) THEN ITERATE generateMac; END IF;
           LEAVE generateMac;
          END LOOP generateMac;
          RETURN mac;
    END;
    CREATE FUNCTION F_tokenFromMac(mac VARBINARY(16))
        RETURNS VARBINARY(16)
        NOT DETERMINISTIC
        BEGIN
          RETURN F_xorKey(mac);

END |