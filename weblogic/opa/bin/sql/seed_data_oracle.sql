﻿-- add initial roles
INSERT INTO ${username}ROLE(role_id, role_name) VALUES (${username}role_seq.NEXTVAL, 'Project Admin');
INSERT INTO ${username}ROLE(role_id, role_name) VALUES (${username}role_seq.NEXTVAL, 'Project Author');
INSERT INTO ${username}ROLE(role_id, role_name) VALUES (${username}role_seq.NEXTVAL, 'Web Service API');
INSERT INTO ${username}ROLE(role_id, role_name) VALUES (${username}role_seq.NEXTVAL, 'Mobile User');

-- add intial users
INSERT INTO ${username}AUTHENTICATION(authentication_id, user_name, full_name, status, hub_admin, user_type)
    VALUES(${username}authentication_seq.NEXTVAL, 'admin', 'Default admin user', 0, 1, 0);

INSERT INTO ${username}AUTHENTICATION(authentication_id, user_name, full_name, status, hub_admin, user_type)
    VALUES(${username}authentication_seq.NEXTVAL, 'author', 'Example project Author/Admin', 1, 0, 0);

INSERT INTO ${username}AUTHENTICATION(authentication_id, user_name, full_name, status, hub_admin, user_type)
    VALUES(${username}authentication_seq.NEXTVAL, 'apiuser', 'Example Determinations/Web API user', 1, 0, 1);

-- Create initial values for the Collection table
INSERT INTO ${username}COLLECTION (collection_id, collection_name, collection_status, collection_description)
VALUES (${username}collection_seq.NEXTVAL, 'Default Collection', 0, 'The default collection');

-- add initial groups.
INSERT INTO ${username}AUTH_ROLE_COLL (collection_id, role_id, authentication_id)
    VALUES ((SELECT collection_id FROM ${username}COLLECTION WHERE collection_name = 'Default Collection'),
    (SELECT role_id FROM ${username}ROLE WHERE role_name = 'Project Admin'),
    (SELECT authentication_id FROM ${username}AUTHENTICATION WHERE user_name = 'admin'));

INSERT INTO ${username}AUTH_ROLE_COLL (collection_id, role_id, authentication_id)
    VALUES ((SELECT collection_id FROM ${username}COLLECTION WHERE collection_name = 'Default Collection'),
    (SELECT role_id FROM ${username}ROLE WHERE role_name = 'Project Author'),
    (SELECT authentication_id FROM ${username}AUTHENTICATION WHERE user_name = 'admin'));

INSERT INTO ${username}AUTH_ROLE_COLL (collection_id, role_id, authentication_id)
    VALUES ((SELECT collection_id FROM ${username}COLLECTION WHERE collection_name = 'Default Collection'),
    (SELECT role_id FROM ${username}ROLE WHERE role_name = 'Project Admin'),
    (SELECT authentication_id FROM ${username}AUTHENTICATION WHERE user_name = 'author'));

INSERT INTO ${username}AUTH_ROLE_COLL (collection_id, role_id, authentication_id)
    VALUES ((SELECT collection_id FROM ${username}COLLECTION WHERE collection_name = 'Default Collection'),
    (SELECT role_id FROM ${username}ROLE WHERE role_name = 'Project Author'),
    (SELECT authentication_id FROM ${username}AUTHENTICATION WHERE user_name = 'author'));

INSERT INTO ${username}AUTH_ROLE_COLL (collection_id, role_id, authentication_id)
    VALUES ((SELECT collection_id FROM ${username}COLLECTION WHERE collection_name = 'Default Collection'),
    (SELECT role_id FROM ${username}ROLE WHERE role_name = 'Web Service API'),
    (SELECT authentication_id FROM ${username}AUTHENTICATION WHERE user_name = 'apiuser'));

-- add initial values for password policies same as default values
INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_invalidLogins', 5, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_passwordExpireIntervalDays', 0, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_passwordExpireGraceDays', 0, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_passwordExpireWarnDays', 0, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_minPasswordLength', 8, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_maxCharacterRepetitions', 0, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_maxCharacterOccurrences', 0, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_minLowercaseChars', 1, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_minUppercaseChars', 1, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_minSpecialChars', 1, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_minNumbersAndSpecialChars', 2, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('pwd_previousPasswordsNoRepeat', 0, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type)
    VALUES ('opm_deploymentModel', 1, 1);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type)
    VALUES ('schema_version', '12.2.11', 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('deployment_max_size_mb', 64, 1, 1, 'Maximum size of any project or deployment that can be uploaded, in millions of bytes.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('runtime_disabled_for_sessions', 0, 1, 0, '0 = enabled, 1 = disabled. If disabled, opa runtime will not be enabled for RN Sessions (customer portal).');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('runtime_disabled_for_users', 0, 1, 0, '0 = enabled, 1 = disabled. If disabled, opa runtime will not be enabled for RN users (Agent Desktop).');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('runtime_enabled_for_employees', 1, 1, 0, '0 = disabled, 1 = enabled. If enabled, interviews are allowed only for employees. Ignored if runtime_disabled_for_users is zero.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('log_level', 'WARN', 0, 1, 'Sets the log level. Valid values: ALL, TRACE, DEBUG, INFO, WARN, ERROR, FATAL, OFF');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('memcached_enabled', 0, 1, 1, 'Enables/disables Memcached 0 = disabled, 1 = enabled');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('memcached_serverList', NULL, 0, 1, 'memcached server list');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('memcached_keyPrefix', NULL, 0, 1, 'memecached key prefix for opa cloud site');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('hub_news_url', '../hub/news/news-{1}.html', 0, 1, 'url for hub news. Substitutions: {0} = version number, {1} = locale string');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('opa_help_url', 'https://documentation.custhelp.com/euf/assets/devdocs/{0}/PolicyAutomation/{1}/Default.htm', 0, 1, 'url for hub help. Substitutions: {0} = version number, {1} = locale string');


INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('web_service_api_status', 1, 1, 0, '0 = unrestricted (for compatibility), 1 = restricted, 2 = unrestricted. When restricted, only users with Web Service API role have access to ODS.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_repository_enabled', 1, 1, 1, '0 = disabled, 1 = enabled. Enabling turns on the Repository feature');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_analytics_enabled', 0, 1, 0, '0 = disabled, 1 = enabled. Enabling turns on the Analytics feature');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_webservice_datasource', 1, 1, 1, '0 = disabled, 1 = enabled. Enabling turns on the Web Service Data Source feature');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_mobile_enabled', 1, 1, 1, '0 = disabled, 1 = enabled. Enabling turns on ability to deploy to Mobile');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_deployment_stats_enabled', 1, 1, 1, '0 = disabled, 1 = enabled. Enabling turns on Deployment Statistics feature');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_compatibility_mode_enabled', 0, 1, 1, '0 = disabled, 1 = enabled. Enabling makes compatibility mode an option for deployments.  Compatibility mode runtime must be installed.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('feature_assess_api_enabled', 1, 1, 1, '0 = disabled, 1 = enabled. Enabling turns on the Assess API feature');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('file_attach_max_mb_single', 10, 1, 1, 'Maximum allowed size in megabytes for a single attachment excluding generated forms');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('file_attach_max_mb_total', 50, 1, 1, 'Maximum allowed total size in megabytes for session attachments excluding generated forms');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('file_attach_name_max_chars', 100, 1, 1, 'Maximum number of characters allowed in a file attachment name');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('osvc_connect_api_version', 'v1_2', 0, 1, 'The version of the Connect API to use for OSvC connections');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('log_billingId', NULL, 0, 1, 'billing id sent to the ACS logging system when a loggable event occurs');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('log_instanceId', NULL, 0, 1, 'instance id sent to the ACS logging system when a loggable event occurs');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('log_trackingHost', NULL, 0, 1, 'tracking host sent to the ACS logging system when a loggable event occurs');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public)
    VALUES ('log_enabled', 0, 1, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('log_outputDirectory', NULL, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public)
    VALUES ('log_outputRecordPerFile', 0, 1, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public)
    VALUES ('log_outputRolloverInterval', 0, 1, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('log_productFamily', NULL, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public)
    VALUES ('log_engagementRequestSecure', 0, 1, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('log_ipForwarderPropertyFile', NULL, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('log_ipForwarderPropertyKey', NULL, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('max_active_deployments', 0, 1, 1, 'The maximum number of active deployments (interview and web service). 0 = no limit');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('det_server_request_validation', 0, 1, 1, 'Enables/disables the validation of Determinations Server requests');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('det_server_response_validation', 0, 1, 1, 'Enables/disables the validation of Determinations Server responses');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('det_server_batch_request_max_mb', 10, 1, 1, 'Maximum allowed size in megabytes for an Assess API batch request');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public)
    VALUES ('deployment_stats_logging_interval', 60, 1, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('deployment_stats_batch_cases_per_session', 25, 1, 1, 'Maximum number of cases included in a session recorded for the batch service');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('interview_timeout_warning_enabled', 1, 1, 1, '0 = disable, 1 = enabled. Enabling turns on user warnings about session expiry for interviews');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('externally_managed_identity', 0, 1, 1, '0 = internally managed, 1 = externally managed by app server, 2 = externally managed by IDCS');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('external_logout_url', null, 0, 1, 'Used for logging out of externally managed opa site');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('interview_cors_whitelist', null, 0, 1, 'A list of whitelisted servers able to make cross site requests to Web Determinations.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_int_value, config_property_type, config_property_public, config_property_description)
    VALUES ('wsc_req_timeout_for_metadata', 20, 1, 1, 'Read timeout in seconds for each Web Service metadata request. One request is made per Hub Model Refresh operation.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('hub_cors_whitelist', '*', 0, 1, 'A ; list of whitelisted servers able to make cross site requests to OPA-Hub.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    VALUES ('det_server_cors_whitelist', '*', 0, 1, 'A ; list of whitelisted servers able to make cross site requests to Determinations Server.');

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('idcs_url', null, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('idcs_audience', null, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('idcs_client_id', null, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public)
    VALUES ('idcs_client_sec', null, 0, 0);

INSERT INTO ${username}CONFIG_PROPERTY (config_property_name, config_property_str_value, config_property_type, config_property_public, config_property_description)
    (SELECT 'clamd_location', null, 0, 1, 'The clamd location, either local path or TCP socket, for virus scanning deployment or project data.' FROM DUAL
        WHERE NOT EXISTS (SELECT * FROM ${username}CONFIG_PROPERTY WHERE config_property_name='clamd_location'));

commit;