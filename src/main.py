import psycopg2
from db_connection import conectar_banco

#importar consultas dps

from consultas import (consulta_1, consulta_2, consulta_3, consulta_4, consulta_5, consulta_6, consulta_7, consulta_8, consulta_9, consulta_10) 
 
def menu_banco():
    while True:
        print("CONSULTAS:\n")
        print("1: Que tipo de serviços um determinado cliente X solicitou no último mês")
        print("2: Qual é a empresa que mais ofereceu serviços à cidade de Y no estado de Z")
        print("3: Quais funcionários (nome e sobrenome) trabalharam para o cliente X no mês Y do ano Z")
        print("4: Listar as solicitações feitas no último ano (nome do cliente, municípios de origem e destino, preço total)")
        print("5: Listar o faturamento das empresas por mês em um ano X")
        print("6: Verificar qual o serviço mais solicitado no último mês entre todas empresas")
        print("7: Listar o serviço mais solicitado e o número de solicitações para cada empresa")
        print("8: Verificar em qual cidade houve o maior número de solicitações")
        print("9: Verificar qual a cidade destino mais referenciada nos pedidos e sua quantidade")
        print("10: Listar para cada empresa o seu faturamento total")
        print("0: Sair")
        
        opcao = input("Escolha uma opção: ")
        
        if opcao == "0":
            print("saindo do menu de consultas...")
            break

        try:
            connection = conectar_banco()
            cursor = connection.cursor()
            
            match opcao:
                case "1":
                    cliente_id = input("digite o ID do cliente: ")
                    resultado = consulta_1(cursor, cliente_id)
                    print("servicos solicitados no último mês:", resultado)
                case "2":
                    cidade = input("digite a cidade: ")
                    estado = input("digite o estado: ")
                    resultado = consulta_2(cursor, cidade, estado)
                    print("empresa que mais ofereceu serviços:", resultado)
                case "3":
                    cliente_id = input("digite o ID do cliente: ")
                    mes = int(input("digite o mês (1-12): "))
                    ano = int(input("digite o ano: "))
                    resultado = consulta_3(cursor, cliente_id, mes, ano)
                    print("funcionários que trabalharam para o cliente:", resultado)
                case "4":
                    resultado = consulta_4(cursor)
                    print("solicitaçoes feitas no último ano:")
                    for row in resultado:
                        print(row)
                case "5":
                    ano = int(input("digite o ano: "))
                    resultado = consulta_5(cursor, ano)
                    print("faturamento das empresas por mês no ano especificado:")
                    for row in resultado:
                        print(row)
                case "6":
                    resultado = consulta_6(cursor)
                    print("servico mais solicitado no último mês:", resultado)
                case "7":
                    resultado = consulta_7(cursor)
                    print("servico mais solicitado e o número de solicitações para cada empresa:")
                    for row in resultado:
                        print(row)
                case "8":
                    resultado = consulta_8(cursor)
                    print("cidade com maior número de solicitações:", resultado)
                case "9":
                    resultado = consulta_9(cursor)
                    print("cidade destino mais referenciada e sua quantidade de pedidos:", resultado)
                case "10":
                    resultado = consulta_10(cursor)
                    print("faturamento total de cada empresa:")
                    for row in resultado:
                        print(row)
                case _:
                    print("opção inválida. tente novamente.")

            cursor.close()
            connection.close()

        except Exception as e:
            print(f"erro inesperado: {e}")
            break

        
if __name__ == "__main__":
    menu_banco()
