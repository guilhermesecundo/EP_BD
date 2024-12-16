from  db_app_connection import conectar_banco
import psycopg2

# 1: Quais serviços um determinado cliente X solicitou no último mês
def consulta_1(cursor, cliente_id):
    query = """
    SELECT s.nome_servico, ds.qtd_horas, p.valor_total, p.data_solicitacao
    FROM SERVICO s
    JOIN DETALHESSERVICO ds ON s.nome_servico = ds.nome_servico
    JOIN PEDIDO p ON ds.cod_pedido = p.cod_pedido
    WHERE p.cod_cliente = %s
      AND p.data_solicitacao >= (CURRENT_DATE - INTERVAL '1 month');
    """
    cursor.execute(query, (cliente_id,))
    return cursor.fetchall()

# 2: Qual é a empresa que mais ofereceu serviços à cidade de Y no estado de Z
def consulta_2(cursor, cidade, estado):
    query = """
    SELECT e.nome_empresa, COUNT(*)
    FROM OFERTASERVICOEM ose
    JOIN EMPRESA e ON ose.nome_empresa = e.nome_empresa
    JOIN CIDADE c ON ose.nome_cidade = c.nome_cidade
    WHERE c.nome_cidade = %s AND c.nome_estado = %s
    GROUP BY e.nome_empresa
    ORDER BY COUNT(*) DESC
    LIMIT 1;
    """
    cursor.execute(query, (cidade, estado))
    return cursor.fetchone()

# 3: Quais funcionários (nome e sobrenome) trabalharam para o cliente X no mês Y do ano Z
def consulta_3(cursor, cliente_id, mes, ano):
    query = """
    SELECT DISTINCT f.nome_funcionario, f.cpf
    FROM FUNCIONARIO f
    JOIN DETALHESSERVICO ds ON f.cpf = ds.cpf_funcionario
    JOIN PEDIDO p ON ds.cod_pedido = p.cod_pedido
    WHERE EXTRACT(MONTH FROM p.data_solicitacao) = %s
      AND EXTRACT(YEAR FROM p.data_solicitacao) = %s
      AND p.cod_cliente = %s;
    """
    cursor.execute(query, (mes, ano, cliente_id))
    return cursor.fetchall()

# 4: Solicitações feitas no último ano, nome do cliente, municípios de origem e destino, e preço total
def consulta_4(cursor):
    query = """
    SELECT p.cod_pedido, c.nome_cliente, p.end_partida, p.end_destino, p.valor_total
    FROM PEDIDO p
    JOIN CLIENTE c ON p.cod_cliente = c.cod_cliente
    WHERE p.data_solicitacao >= (CURRENT_DATE - INTERVAL '1 year');
    """
    cursor.execute(query)
    return cursor.fetchall()

# 5: Faturamento das empresas por mês em um ano X
def consulta_5(cursor, ano):
    query = """
    SELECT e.nome_empresa, EXTRACT(MONTH FROM p.data_solicitacao) AS mes, SUM(p.valor_total) AS faturamento
    FROM PEDIDO p
    JOIN DETALHESSERVICO ds ON p.cod_pedido = ds.cod_pedido
    JOIN OFERTASERVICOEM ose ON ds.nome_servico = ose.nome_servico
    JOIN EMPRESA e ON ose.nome_empresa = e.nome_empresa
    WHERE EXTRACT(YEAR FROM p.data_solicitacao) = %s
    GROUP BY e.nome_empresa, mes
    ORDER BY e.nome_empresa, mes;
    """
    cursor.execute(query, (ano,))
    return cursor.fetchall()

# 6: Serviço mais solicitado no último mês entre todas empresas
def consulta_6(cursor):
    query = """
    SELECT s.nome_servico, COUNT(*) AS num_solicitacoes
    FROM DETALHESSERVICO ds
    JOIN SERVICO s ON ds.nome_servico = s.nome_servico
    WHERE ds.data_efetivacao >= (CURRENT_DATE - INTERVAL '1 month')
    GROUP BY s.nome_servico
    ORDER BY num_solicitacoes DESC
    LIMIT 1;
    """
    cursor.execute(query)
    return cursor.fetchone()

# 7: Serviço mais solicitado e o número de solicitações para cada empresa
def consulta_7(cursor):
    query = """
    SELECT e.nome_empresa, s.nome_servico, COUNT(*) AS num_solicitacoes
    FROM DETALHESSERVICO ds
    JOIN OFERTASERVICOEM ose ON ds.nome_servico = ose.nome_servico
    JOIN EMPRESA e ON ose.nome_empresa = e.nome_empresa
    JOIN SERVICO s ON ds.nome_servico = s.nome_servico
    GROUP BY e.nome_empresa, s.nome_servico
    ORDER BY e.nome_empresa, num_solicitacoes DESC;
    """
    cursor.execute(query)
    return cursor.fetchall()

# 8: Cidade com o maior número de solicitações
def consulta_8(cursor):
    query = """
    SELECT p.end_destino AS cidade_destino, COUNT(*) AS num_solicitacoes
    FROM PEDIDO p
    GROUP BY p.end_destino
    ORDER BY num_solicitacoes DESC
    LIMIT 1;
    """
    cursor.execute(query)
    return cursor.fetchone()

# 9: Cidade destino mais referenciada nos pedidos e a quantidade de pedidos
def consulta_9(cursor):
    query = """
    SELECT p.end_destino, COUNT(*) AS num_pedidos
    FROM PEDIDO p
    GROUP BY p.end_destino
    ORDER BY num_pedidos DESC
    LIMIT 1;
    """
    cursor.execute(query)
    return cursor.fetchone()

# 10: Faturamento total por empresa
def consulta_10(cursor):
    query = """
    SELECT e.nome_empresa, SUM(p.valor_total) AS faturamento_total
    FROM PEDIDO p
    JOIN DETALHESSERVICO ds ON p.cod_pedido = ds.cod_pedido
    JOIN OFERTASERVICOEM ose ON ds.nome_servico = ose.nome_servico
    JOIN EMPRESA e ON ose.nome_empresa = e.nome_empresa
    GROUP BY e.nome_empresa
    ORDER BY faturamento_total DESC;
    """
    cursor.execute(query)
    return cursor.fetchall()
