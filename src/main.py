import tkinter as tk
from tkinter import ttk
import psycopg2
from consultas import (consulta_1, consulta_2, consulta_3, consulta_4, consulta_5, consulta_6, consulta_7, consulta_8, consulta_9, consulta_10)
from db_app_connection import conectar_banco
from tabulate import tabulate

opcoes = [
    "Tipo de serviços que um determinado cliente solicitou no último mês",
    "Empresa que mais ofereceu serviços à cidade Y do estado Z",
    "Funcionários que trabalharam para o cliente X no mês Y do ano Z",
    "Solicitações feitas no último ano, junto ao cliente, locais e preço total de cada solicitação",
    "Faturamento das empresas por mês em um ano X.",
    "Serviço mais solicitado no último mês entre todas empresas",
    "Nome do serviço mais solicitado, e o número de solicitações para cada empresa",
    "Cidade com o maior número de solicitações",
    "Cidade destino mais referenciada nos pedidos e a sua quantidade de pedidos",
    "Empresas e o seu faturamento total"
]

opcoes_num_param = [
    ["Nome do Cliente"],
    ["Nome da Cidade", "Nome do Estado"],
    ["Nome do Cliente", "Mês", "Ano"],
    [],
    ["Ano"],
    [],
    [],
    [],
    [],
    []
]

cabecalho = [
    ["Nome Servico", "Horas", "Total", "Data de Solicitação"],
    ["Nome da Empresa", "Quantidade"],
    ["Nome do Funcionario", "CPF"],
    ["Pedido", "Nome do Cliente", "Origem", "Destino", "Preço Total"],
    ["Nome da Empresa", "Mês", "Faturamento"],
    ["Nome do Serviço", "Quantidade"],
    ["Nome da Empresa", "Nome do Servico", "Solicitações"],
    ["Nome da Cidade", "Quantidade"],
    ["Nome da Cidade", "Quantidade"],
    ["Nome da Empresa", "Faturamento Total"]
]

def consulta():
    resultado_texto.delete("1.0","end")
    query = menu_dropdown.current() + 1
    query_params = [] 
    
    num_options = len(opcoes_num_param[query-1])
    query = str(query)
    if num_options > 0:
        query_params.append(input_param1.get())
    if num_options > 1:
        query_params.append(input_param2.get())
    if num_options > 2:
        query_params.append(input_param3.get())
        

    resultado = connect_to_db(query, query_params)

    if resultado and isinstance(resultado, tuple):  # Se for uma única linha (tupla)
        resultado = [resultado]
    
    resultado_texto.insert(tk.END, tabulate(resultado, headers=cabecalho[int(query) - 1], tablefmt="grid"))
        

def connect_to_db(query, query_params):
    resultado = ""
    try:
        connection = conectar_banco()
        cursor = connection.cursor()
        match query:
            case "1":
                cliente_id = query_params[0]
                resultado = consulta_1(cursor, cliente_id)
            case "2":
                cidade = query_params[0]
                estado = query_params[1]
                resultado = consulta_2(cursor, cidade, estado)
            case "3":
                cliente_id = query_params[0]
                mes = int(query_params[1])
                ano = int(query_params[2])
                resultado = consulta_3(cursor, cliente_id, mes, ano)
            case "4":
                resultado = consulta_4(cursor)
            case "5":
                ano = int(query_params[0])
                resultado = consulta_5(cursor, ano)
            case "6":
                resultado = consulta_6(cursor)

            case "7":
                resultado = consulta_7(cursor)
            case "8":
                resultado = consulta_8(cursor)
            case "9":
                resultado = consulta_9(cursor)
            case "10":
                resultado = consulta_10(cursor)

        cursor.close()
        connection.close()

    except Exception as e:
        print(f"erro inesperado: {e}")
    return resultado

#Interface

def show_param1(new_text):
    lbl_param1.place(x=10, y=50, width=120, height=25)
    lbl_param1.config(text = new_text)
    input_param1.place(x=135, y=50, width=200, height=25)

def show_param2(new_text):
    lbl_param2.place(x=10, y=90, width=120, height=25)
    lbl_param2.config(text = new_text)
    input_param2.place(x=135, y=90, width=200, height=25)

def show_param3(new_text):
    lbl_param3.place(x=10, y=130, width=120, height=25)
    lbl_param3.config(text = new_text)
    input_param3.place(x=135, y=130, width=200, height=25)

def hide_all():
    lbl_param1.place_forget()
    input_param1.place_forget()
    input_param1.delete(0, "end")

    lbl_param2.place_forget()
    input_param2.place_forget()
    input_param2.delete(0, "end")

    lbl_param3.place_forget()
    input_param3.place_forget()
    input_param3.delete(0, "end")

def option_selected(event):
    hide_all()
    index = menu_dropdown.current()
    num_options = len(opcoes_num_param[index])
    if num_options > 0:
        show_param1(opcoes_num_param[index][0])
    if num_options > 1:
        show_param2(opcoes_num_param[index][1])
    if num_options > 2:
        show_param3(opcoes_num_param[index][2])


janela = tk.Tk()
janela.title("Interface de Consulta ao Banco de Dados")

janela.geometry("760x500")
janela.resizable(False, False)

# Dropdown
label1 = tk.Label(janela, text="Selecione a consulta", anchor="w")
label1.place(x=10, y=10, width=120, height=25)

menu_dropdown = ttk.Combobox(janela, values=opcoes, state="readonly")
menu_dropdown.set(opcoes[0])
menu_dropdown.place(x=135, y=10, width=610, height=25)
menu_dropdown.bind("<<ComboboxSelected>>", option_selected)

# Inputs e Labels
lbl_param1 = tk.Label(janela, text="Nome do Cliente", anchor="w")
lbl_param1.place(x=10, y=50, width=120, height=25)

input_param1 = tk.Entry(janela)
input_param1.place(x=135, y=50, width=200, height=25)

lbl_param2 = tk.Label(janela, text="", anchor="w")
input_param2 = tk.Entry(janela)

lbl_param3 = tk.Label(janela, text="", anchor="w")
input_param3 = tk.Entry(janela)

# Botão Consultar
btn_consultar = tk.Button(janela, text="Consultar", command=consulta)
btn_consultar.place(x=665, y=240, width=80, height=25)

# Área de Resultados
resultado_label = tk.Label(janela, text="Área de Resultados")
resultado_label.place(x=10, y=240, width=120, height=25)

# Frame para organizar Text e Scrollbar
resultado_frame = tk.Frame(janela)
resultado_frame.place(x=10, y=270, width=735, height=220)

# Scrollbar vertical
scrollbar = tk.Scrollbar(resultado_frame)
scrollbar.pack(side="right", fill="y")

# Área de texto (associada à Scrollbar)
resultado_texto = tk.Text(resultado_frame, height=10, yscrollcommand=scrollbar.set, wrap="none")
resultado_texto.pack(side="left", fill="both", expand=True)

# Configurar Scrollbar para controlar a área de texto
scrollbar.config(command=resultado_texto.yview)
scrollbar.config(command=resultado_texto.xview)

# Iniciar o loop da interface
janela.mainloop()


