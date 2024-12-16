import psycopg2

def conectar_banco(dbname="dbname"):

    #mudar conforme configurações do banco

    try:
        conn = psycopg2.connect(
            dbname=dbname,  
            user="postgres",             
            password="12345",             
            host="localhost",            
            port="5432"                  
        )
        return conn
    
    except Exception as e:
        return None

