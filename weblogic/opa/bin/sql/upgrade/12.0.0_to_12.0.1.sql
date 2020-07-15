ALTER TABLE ANALYSIS_WORKSPACE 
  MODIFY workspace_description 
  VARCHAR(1024) CHARACTER SET utf8;

ALTER TABLE ANALYSIS_PARAMETER 
  MODIFY parameter_name 
  VARCHAR(255) CHARACTER SET utf8 NOT NULL;

DROP FUNCTION IF EXISTS OPAColumnExists;
DROP PROCEDURE IF EXISTS OPAUpgradeAnalysisParameters;
DELIMITER ;PROC;

CREATE PROCEDURE OPAUpgradeAnalysisParameters()
DETERMINISTIC
BEGIN
	DECLARE colExists INT;
    SELECT COUNT(1) INTO colExists FROM INFORMATION_SCHEMA.COLUMNS WHERE 
    	TABLE_SCHEMA= convert(database() USING utf8) COLLATE utf8_general_ci
    	AND TABLE_NAME= convert('ANALYSIS_PARAMETER' USING utf8) COLLATE utf8_general_ci
    	AND COLUMN_NAME=convert('parameter_value' USING utf8) COLLATE utf8_general_ci;
    	
    IF colExists = 0 THEN
		ALTER TABLE ANALYSIS_PARAMETER 
			ADD COLUMN parameter_value VARCHAR(255) CHARACTER SET utf8 NULL;
		UPDATE ANALYSIS_PARAMETER
			SET parameter_value = IF(boolean_value=1,'true','false')
			WHERE parameter_value is null and boolean_value is not null;
		UPDATE ANALYSIS_PARAMETER
			SET parameter_value = coalesce(number_value, text_value, time_value, date_value, DATE_FORMAT(datetime_value, '%Y-%m-%dT%TZ'))
			WHERE parameter_value is null;
			
		ALTER TABLE ANALYSIS_PARAMETER
			DROP COLUMN boolean_value,
			DROP COLUMN number_value,
			DROP COLUMN text_value,
			DROP COLUMN date_value,
			DROP COLUMN time_value,
			DROP COLUMN datetime_value,
			DROP COLUMN other_value;
    END IF;
    
END; ;PROC;
DELIMITER ;

SET SQL_SAFE_UPDATES=0;
CALL OPAUpgradeAnalysisParameters();

-- empty config properties for analysis server
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_dbDriver', NULL, 0, 1, 'Driver class for the analysis output database') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
	
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_procType', NULL, 0, 1, 'Processor type to be used by the analysis server') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
	
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_procPath', NULL, 0, 1, 'Path to the batch processor to be launched by the analysis server') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
	
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_procCount', NULL, 1, 1, 'Number of parallel processors to be used by the batch processor') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
	
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_procLimit', NULL, 1, 1, 'Maximum number of cases to be processed by the analysis server for each scenario') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
		
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_blockSize', NULL, 1, 1, 'Maximum number of cases to read/written by the analysis server per processor transaction') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
	
INSERT INTO CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description) 
	VALUES ('analysis_batch_dbDriverPath', NULL, 0, 1, 'Path to the JDBC driver to be used by the analyisis server to read input data') 
	ON DUPLICATE KEY UPDATE config_property_name = config_property_name;
	
ALTER TABLE SECURITY_TOKEN MODIFY authentication_id INT NULL;

-- switch all tables to InnoDB engine
ALTER TABLE ANALYSIS_CHART ENGINE=InnoDB;
ALTER TABLE ANALYSIS_PARAMETER ENGINE=InnoDB;
ALTER TABLE ANALYSIS_SCENARIO ENGINE=InnoDB;
ALTER TABLE ANALYSIS_WORKSPACE ENGINE=InnoDB;
ALTER TABLE AUTHENTICATION ENGINE=InnoDB;
ALTER TABLE AUTHENTICATION_PWD ENGINE=InnoDB;
ALTER TABLE AUTHENTICATION_ROLE ENGINE=InnoDB;
ALTER TABLE CONFIG_PROPERTY ENGINE=InnoDB;
ALTER TABLE DATA_SERVICE ENGINE=InnoDB;
ALTER TABLE DEPLOYMENT ENGINE=InnoDB;
ALTER TABLE DEPLOYMENT_ACTIVATION_HISTORY ENGINE=InnoDB;
ALTER TABLE DEPLOYMENT_RULEBASE_REPOS ENGINE=InnoDB;
ALTER TABLE DEPLOYMENT_VERSION ENGINE=InnoDB;
ALTER TABLE LOG_ENTRY ENGINE=InnoDB;
ALTER TABLE PROJECT ENGINE=InnoDB;
ALTER TABLE PROJECT_OBJECT_STATUS ENGINE=InnoDB;
ALTER TABLE PROJECT_VERSION ENGINE=InnoDB;
ALTER TABLE PROJECT_VERSION_CHANGE ENGINE=InnoDB;
ALTER TABLE ROLE ENGINE=InnoDB;
ALTER TABLE SECURITY_TOKEN ENGINE=InnoDB;
ALTER TABLE SNAPSHOT ENGINE=InnoDB;
ALTER TABLE SNAPSHOT_CHUNK ENGINE=InnoDB;

