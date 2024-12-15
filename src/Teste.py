import tkinter as tk

# Criar a janela principal
root = tk.Tk()
root.title("Área de Texto Rolável")
root.geometry("500x400")  # Tamanho inicial da janela

# Criar um Frame para organizar os widgets
frame = tk.Frame(root)
frame.pack(expand=True, fill='both')

# Criar a Scrollbar Vertical
scrollbar = tk.Scrollbar(frame)
scrollbar.pack(side='right', fill='y')

# Criar a área de texto e associá-la à scrollbar
text_area = tk.Text(frame, wrap='word', yscrollcommand=scrollbar.set)
text_area.pack(expand=True, fill='both')

# Configurar a scrollbar para rolar a área de texto
scrollbar.config(command=text_area.yview)

# Inserir algum texto de exemplo
for i in range(1, 101):
    text_area.insert('end', f"Esta é a linha {i}\n")

# Executar o loop principal do Tkinter
root.mainloop()
