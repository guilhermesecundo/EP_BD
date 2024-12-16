from db_connection import conectar_banco

def cria_banco():
    conn = conectar_banco("postgres")
    if not conn:
        return False

    try:
        cursor = conn.cursor()

        cursor.execute("SELECT 1 FROM pg_database WHERE datname = 'mudancas_servicos'")
        if cursor.fetchone():
            print("O banco 'mudancas_servicos' já existe.")
        else:
            cursor.close()  
            conn.close()    

            conn = conectar_banco("postgres")
            conn.autocommit = True  
            cursor = conn.cursor()
            
            cursor.execute("CREATE DATABASE mudancas_servicos")
            print("O banco 'mudancas_servicos' foi criado!")

        cursor.close()  
        conn.close()  
        return True

    except Exception as e:
        print(f"Erro ao criar o banco: {e}")
        return False

