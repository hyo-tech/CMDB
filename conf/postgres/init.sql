-- setup scripts which will only run when the postgres container is setup for the first time, re: no data
CREATE DATABASE cmdb_test;
CREATE DATABASE keycloak;
CREATE DATABASE proxy;
GRANT ALL PRIVILEGES ON DATABASE keycloak TO postgres;