
import psycopg2
import psycopg2.extras
from dotenv import load_dotenv
import os
from clickhouse_connect import get_client
import json

load_dotenv()
host = os.environ['PG_HOST']
user = os.environ['PG_USER']
password = os.environ['PG_PASSWORD']
port = os.environ['PG_PORT']
db_name = 'inventory'
slot_name = 'inventory'
ch_host = os.environ['CH_HOST']
ch_user = os.environ['CH_USER']
ch_password = os.environ['CH_PASSWORD']

def connect_clickhouse():
    return get_client(
        host=ch_host,
        user=ch_user,
        password=ch_password,
        database=db_name,
        secure=True
    )

def connect_postgres():
    return psycopg2.connect(
        f"host={host} user={user} password={password} port={port} dbname={db_name}",
        connection_factory=psycopg2.extras.LogicalReplicationConnection
    ).cursor()

class DemoConsumer(object):
    def __call__(self, msg):
        sync_to_clickhouse(msg.payload)
        msg.cursor.send_feedback(flush_lsn=msg.data_start)


replication_options = {
    "include-xids": "1",
    "include-timestamp": "1",
    "pretty-print": "1",
    "include-types": "1",
    "include-typmod": "0",

}

def gen_sql(row,action):
    table = row['table']
    count = 0
    ch_conn = connect_clickhouse()
    if action == 'insert':
        col_names = row['columnnames']
        col_vals = row['columnvalues']
        col_types = row['columntypes']
        col_names_string = ",".join(str(col) for col in col_names)
        col_names_string = f"({col_names_string},sign)"
        vals = f"VALUES("
        for col_val in col_vals:
            if(col_types[count] == 'varchar' or col_types[count] == 'date'):
                col_val = f"'{col_val}'"
            vals += f"{col_val}, "
            count+=1
        vals = vals + f"1)"
        sql = f"INSERT INTO {table}{col_names_string} {vals}"
        print(sql)
        ch_conn.command(sql)
    elif action == 'cancel':
       
        prim_key = row['oldkeys']['keynames'][0]
        prim_key_data_type = row['oldkeys']['keytypes'][0]
        prim_key_val  = row['oldkeys']['keyvalues'][0]
        if(prim_key_data_type== 'varchar' or prim_key_data_type== 'date'):
                prim_key_val = f"'{prim_key_val}'"
        sql = f"INSERT INTO {table}({prim_key},sign) VALUES({prim_key_val}, -1)"
        print(sql)
        ch_conn.command(sql)
    

def sync_to_clickhouse(payload):
    print(payload)
    payload = json.loads(payload)
    if len(payload['change']) > 0:
        row = payload['change'][0] 
        kind = row['kind']  
        if kind == 'insert':
            gen_sql(row,'insert')
        elif kind == 'update':
            gen_sql(row,'cancel')
            gen_sql(row,'insert')
        elif kind == 'delete':
            gen_sql(row,'cancel')
    



        




if __name__ == '__main__':

    pg_cursor = connect_postgres()
    ch_conn = connect_clickhouse()
    
    try:
        pg_cursor.start_replication(slot_name=slot_name, decode=True, options=replication_options)
    except psycopg2.ProgrammingError:
        pg_cursor.create_replication_slot(slot_name, output_plugin="wal2json")
        pg_cursor.start_replication(slot_name=slot_name, decode=True, options=replication_options)

    democonsumer = DemoConsumer()

    try:
        pg_cursor.consume_stream(democonsumer)
    except KeyboardInterrupt:
        pg_cursor.close()
        pg_cursor.close()
        ch_conn.close()
   