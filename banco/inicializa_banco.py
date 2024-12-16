from cria_banco import cria_banco
from cria_tabelas import cria_tabelas
from insere_dados import insere_dados

def inicializa_banco():
    if cria_banco():
        if cria_tabelas():
             insere_dados()


if __name__ == "__main__":
    inicializa_banco()
    print("Banco inicializado com sucesso!")