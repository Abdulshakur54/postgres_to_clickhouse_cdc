## Postgres-Clickhouse CDC Project

### This projects synchronizes three tables in Postgres database with its counterparts in Clickhouse.

## PostgreSQL
the source data is from PostgreSQL 16. I enable . I enabled logical replication by setting wal_level to 1 in postgresql.conf file.
I used the default value for replication_control so as to minimize the size of my WAL files.
I created a new user with the least permission needed for database replication

## Psycopg2 and wal2json
I used wal2json for reading the WAL files into a readable format.
Psycopg2 library has support for replication control and reading from wal2json.
I used it to track the lsn via its xid attribute

# clickhouse-connect
I used this package to connect to the clickhouse server.
my tables used the CollapsingMergeTree Engine due to frequnt updates


