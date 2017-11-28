#!/bin/sh

# apollo config db info
apollo_config_db_url=jdbc:mysql://172.22.0.17:6033/ApolloConfigDB?characterEncoding=utf8
apollo_config_db_username=cat
apollo_config_db_password=mVEv24taitYh

# apollo portal db info
apollo_portal_db_url=jdbc:mysql://172.22.0.17:6033/ApolloPortalDB?characterEncoding=utf8
apollo_portal_db_username=cat
apollo_portal_db_password=mVEv24taitYh

# meta server url, different environments should have different meta server addresses
test_meta=http://172.20.70.78:8008
pro_meta=http://172.20.93.36:8080

META_SERVERS_OPTS="-Dtest_meta=$test_meta -Dpro_meta=$pro_meta"

outputDirectory=target-test

# =============== Please do not modify the following content =============== #
# go to script directory
cd "${0%/*}"

cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password  -DoutputDirectory=$outputDirectory

echo "==== building config-service and admin-service finished ===="

echo "==== building client finished ===="

