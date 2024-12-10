from db_connection import conectar_banco

import psycopg2


#1: Quais serviços um determinado cliente X solicitou no último mês
# def consulta_1(cursor, cliente_id):   

#2: Qual é a empresa que mais ofereceu serviços à cidade de Y no estado de Z
def consulta_2(cursor, cidade, estado):
    query = """
    SELECT nome_empresa, COUNT(*) AS qtd_servicos
    FROM ofertaservicoem
    WHERE nome_cidade = %s
    AND nome_estado = %s
    GROUP BY nome_empresa
    ORDER BY qtd_servicos DESC
    LIMIT 1
    """
    cursor.execute(query, (cidade, estado))
    return cursor.fetchone()

#3: Quais funcionários (nome e sobrenome) trabalharam para o cliente X no mês Y do ano Z
def consulta_3(cursor, cliente_id, mes, ano):
    query = """
    SELECT DISTINCT f.nome_funcionario, f.sobrenome_funcionario
    FROM funcionario f
    JOIN detalhes_servico ds ON f.cpf = ds.cpf_funcionario
    JOIN pedido p ON ds.cod_pedido = p.cod_pedido
    WHERE p.cod_cliente = %s
    AND EXTRACT(MONTH FROM p.data_solicitacao) = %s
    AND EXTRACT(YEAR FROM p.data_solicitacao) = %s
    """
    cursor.execute(query, (cliente_id, mes, ano))
    return cursor.fetchall()

#4: Listar as solicitações foram feitas no último ano, nome do cliente que as realizou, municípios de origem e destino (se houver) e preço total de cada solicitação.