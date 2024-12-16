from db_connection import conectar_banco

def cria_tabelas():
    conn = conectar_banco("mudancas_servicos")
    if not conn:
        return False

    try:
        file = open("scripts_pgadmin/mudanças_serviços.sql", 'r', encoding='utf-8')
        sql_commands = file.read()
        file.close()  
        
        cursor = conn.cursor()
        cursor.execute(sql_commands)
        conn.commit()
        cursor.close()
        return True

    finally:
        conn.close()
