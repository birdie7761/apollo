#!/bin/sh

# apollo config db info
apollo_config_db_url=jdbc:mysql://proxysql-pro.service.consul:6033/ApolloConfigDB?characterEncoding=utf8
apollo_config_db_username=cat
apollo_config_db_password=mVEv24taitYh

# apollo portal db info
apollo_portal_db_url=jdbc:mysql://proxysql-pro.service.consul:6033/ApolloPortalDB?characterEncoding=utf8
apollo_portal_db_username=cat
apollo_portal_db_password=mVEv24taitYh

# meta server url, different environments should have different meta server addresses
test_meta=http://apollo-test.service.consul:8008
pro_meta=http://apollo-pro.service.consul:8080

META_SERVERS_OPTS="-Dtest_meta=$test_meta -Dpro_meta=$pro_meta"

outputDirectory=target-pro

# =============== Please do not modify the following content =============== #
# go to script directory
cd "${0%/*}"

cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password -DoutputDirectory=$outputDirectory

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=$apollo_portal_db_url -Dspring_datasource_username=$apollo_portal_db_username -Dspring_datasource_password=$apollo_portal_db_password $META_SERVERS_OPTS

echo "==== building portal finished ===="

echo "==== starting to build client ===="

mvn clean install -DskipTests -pl apollo-client -am $META_SERVERS_OPTS

echo "==== building client finished ===="

