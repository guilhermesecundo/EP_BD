
# EP 3 - Banco de Dados I

Este projeto é a terceira parte do trabalho da disciplina de Banco de Dados I. Este trabalho consiste em criar e implementar um banco de dados para um sistema de gerenciamento de serviços de mudanças.

O banco de dados foi desenvolvido e implementado no PostgreSQL. Foi gerado um script SQL que cria as tabelas necessárias e insere dados suficientes para testar as consultas e o trigger.

---

## Ferramentas de Desenvolvimento

- Python 
- PostgreSQL 
- Tkinter (para interface gráfica)

---

## Dependências

Antes de rodar o projeto, instale as seguintes bibliotecas:

- **Psycopg2**

  Para conectar ao banco de dados PostgreSQL:

  ```
  pip install psycopg2
  ```

  [Documentação de instalação do Psycopg2](https://www.psycopg.org/docs/install.html#quick-install)

- **Tabulate**

  Para formatar tabelas e exibir consultas:

  ```
  pip install tabulate
  ```

---

## Como rodar o projeto

1. **Configurar a conexão com o banco de dados:**

   Altere a função `def conectar_banco` nos arquivos `db_app_connection.py` e `db_connection.py`, adicionando as informações do servidor local (host, user, password, database, port).

2. **Inicializar o banco de dados:**

   Rode o arquivo `inicializa_banco.py`. Ele executará dois scripts:

   - `mundaças_servicos.sql`: Contém a estrutura do banco de dados (DDL).
   - `script_inserção.sql`: Contém os comandos `INSERT` 

   Para rodar o script, execute o seguinte comando no terminal:

   ```
   python banco/inicializa_banco.py
   ```

3. **Utilizar o sistema:**

   Execute o arquivo `main.py`, que abre a interface gráfica baseada na biblioteca `Tkinter`. Essa interface permite testar as consultas.

   Para rodar o sistema, use:

   ```
   python src/main.py
   ```

