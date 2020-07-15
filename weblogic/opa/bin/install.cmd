
SET INSTALL_CP=".;lib/opa-hub.jar;lib/determinations-utilities.jar;lib/hub-util.jar;lib/log4j-1.2-api-2.10.0.jar;lib/log4j-api-2.10.0.jar;lib/log4j-core-2.10.0.jar;lib/mysql-connector-java-5.1.46-bin.jar;lib/ojdbc7.jar;lib/orai18n.jar;lib/spymemcached-2.10.3.jar;lib/velocity-1.7-dep.jar"
java -cp "%INSTALL_CP%" com.oracle.determinations.hub.exec.HubExecCmdLineCustomer %*
