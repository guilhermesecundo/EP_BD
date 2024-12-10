import psycopg2

def conectar_banco():

    #mudar conforme configurações do banco

    try:
        conn = psycopg2.connect(
            dbname="mudancas_servicos",  
            user="postgres",             
            password="1234",             
            host="localhost",            
            port="5432"                  
        )
        return conn
    
    except Exception as e:
        return None
