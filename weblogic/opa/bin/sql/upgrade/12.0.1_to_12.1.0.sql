-- some update without a where clause are needed
SET SQL_SAFE_UPDATES=0; 

DROP PROCEDURE IF EXISTS OPAAddColumnIfNotExists;
DROP PROCEDURE IF EXISTS OPADropIndexIfExists;

DELIMITER ;PROC;
CREATE PROCEDURE OPAAddColumnIfNotExists(
    tableName VARCHAR(64),
    colName VARCHAR(64),
    colDef VARCHAR(2048)
)
DETERMINISTIC
BEGIN
    DECLARE colExists INT;
    DECLARE dbName VARCHAR(64);
    SELECT database() INTO dbName;
    SELECT COUNT(1) INTO colExists
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = convert(dbName USING utf8) COLLATE utf8_general_ci
            AND TABLE_NAME = convert(tableName USING utf8) COLLATE utf8_general_ci
            AND COLUMN_NAME = convert(colName USING utf8) COLLATE utf8_general_ci;
    IF colExists = 0 THEN
        SET @sql = CONCAT('ALTER TABLE ', tableName, ' ADD COLUMN ', colName, ' ', colDef);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
    END IF;
END;
;PROC;

CREATE PROCEDURE OPADropIndexIfExists(
	tableName VARCHAR(64),
	indexName VARCHAR(128) )
DETERMINISTIC
BEGIN
    DECLARE colExists INT;
    DECLARE dbName VARCHAR(64);
    SELECT database() INTO dbName;

	select COUNT(1) INTO colExists 
		FROM INFORMATION_SCHEMA.STATISTICS 
        WHERE TABLE_SCHEMA = convert(dbName USING utf8) COLLATE utf8_general_ci
            AND TABLE_NAME = convert(tableName USING utf8) COLLATE utf8_general_ci
            AND INDEX_NAME = convert(indexName USING utf8) COLLATE utf8_general_ci;
			
	IF colExists > 0 THEN
		SET @sql = CONCAT('ALTER TABLE ', tableName, ' DROP INDEX ' ,indexName);
		PREPARE stmt FROM @sql;
		EXECUTE stmt;
	END IF;
END;
;PROC;

DELIMITER ;

UPDATE CONFIG_PROPERTY SET 
	config_property_str_value='https://documentation.custhelp.com/euf/assets/devdocs/{0}/PolicyAutomation/{1}/extra/hub/news_frag.htm' 
	WHERE config_property_name='hub_news_url';
	
UPDATE CONFIG_PROPERTY SET 
	config_property_str_value='https://documentation.custhelp.com/euf/assets/devdocs/{0}/PolicyAutomation/{1}/Default.htm' 
	WHERE config_property_name='opa_help_url';

-- add version column to data_service table and set version value web service connections
CALL OPAAddColumnIfNotExists('DATA_SERVICE', 'version', 'VARCHAR(20) CHARACTER SET utf8 NULL');
CALL OPAAddColumnIfNotExists('DATA_SERVICE', 'wss_use_timestamp', 'SMALLINT DEFAULT 0 NOT NULL');
CALL OPAAddColumnIfNotExists('DATA_SERVICE', 'bearer_token_param', 'VARCHAR(255) CHARACTER SET utf8');
CALL OPAAddColumnIfNotExists('DATA_SERVICE', 'use_wss', 'SMALLINT DEFAULT 0 NOT NULL');

UPDATE DATA_SERVICE SET version = "12.0" WHERE service_type="WebService" AND version IS NULL;
UPDATE DATA_SERVICE SET use_wss = 1 WHERE service_type="WebService" AND use_wss = 0 and service_user is not null and service_user != "";


-- determinations server configuration options
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_str_value, config_property_type, config_property_public, config_property_description)
VALUES ('det_server_request_validation', 0, NULL, 1, 1, 'Enables/disables the validation of Determinations Server requests')
ON DUPLICATE KEY UPDATE config_property_name = config_property_name;

INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_str_value, config_property_type, config_property_public, config_property_description)
VALUES ('det_server_response_validation', 0, NULL, 1, 1, 'Enables/disables the validation of Determinations Server responses')
ON DUPLICATE KEY UPDATE config_property_name = config_property_name;

-- add Mobile feature switch to configuration options
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_str_value, config_property_type, config_property_public, config_property_description)
VALUES ('feature_mobile_enabled', 0, NULL, 1, 1, '0 = disabled, 1 = enabled. Enabling turns on ability to deploy to Mobile')
ON DUPLICATE KEY UPDATE config_property_name = config_property_name;

-- add columns for mobile deployments to DEPLOYMENT table
CALL OPAAddColumnIfNotExists('DEPLOYMENT', 'activated_mobile', 'SMALLINT DEFAULT 0 NOT NULL');

-- add columns for mobile deployments to DEPLOYMENT_ACTIVATION_HISTORY table
CALL OPAAddColumnIfNotExists('DEPLOYMENT_ACTIVATION_HISTORY', 'status_mobile', 'SMALLINT DEFAULT 0 NOT NULL');

-- We now allow multiple tokens per user
CALL OPADropIndexIfExists('SECURITY_TOKEN', 'sec_unique_authentication_id');

INSERT IGNORE INTO ROLE(role_name) values ('Mobile User');
