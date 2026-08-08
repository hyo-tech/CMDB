-- setup scripts which will only run when the postgres container is setup for the first time, re: no data
SELECT 'CREATE DATABASE hyo_itom'
WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = 'hyo_itom'
)\gexec
;

SELECT 'CREATE DATABASE hyo_keycloak'
WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = 'hyo_keycloak'
)\gexec
;

SELECT 'CREATE DATABASE hyo_proxy'
WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = 'hyo_proxy'
)\gexec
;

SELECT 'CREATE DATABASE hyo_langfuse'
WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = 'hyo_langfuse'
)\gexec
;

GRANT ALL PRIVILEGES ON DATABASE hyo_keycloak TO postgres;
GRANT ALL PRIVILEGES ON DATABASE hyo_langfuse TO postgres;