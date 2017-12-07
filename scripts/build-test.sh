#!/bin/sh

# apollo config db info
apollo_config_db_url=jdbc:mysql://proxysql-test.service.consul:6033/ApolloConfigDB?characterEncoding=utf8
apollo_config_db_username=
apollo_config_db_password=

outputDirectory=target-test

# =============== Please do not modify the following content =============== #
# go to script directory
cd "${0%/*}"

cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password  -DoutputDirectory=$outputDirectory

echo "==== building config-service and admin-service finished ===="

