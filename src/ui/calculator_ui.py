import customtkinter as ctk

class CalculatorUI(ctk.CTkFrame):
    def __init__(self, master, calcular_callback):
        super().__init__(master)
        self.calcular_callback = calcular_callback

        for i in range(6):  
            self.rowconfigure(i, weight=1)
        for j in range(4):
            self.columnconfigure(j, weight=1)

        self.display = ctk.CTkEntry(self, font=("Arial", 24), height=80)
        self.display.grid(row=0, column=0, columnspan=4, sticky="nsew", pady=10, padx=5)
        self._criar_botoes()

    def _criar_botoes(self):
        botoes = [
            ("7", 1, 0), ("8", 1, 1), ("9", 1, 2), ("⌫", 1, 3),
            ("4", 2, 0), ("5", 2, 1), ("6", 2, 2), ("C", 2, 3),
            ("1", 3, 0), ("2", 3, 1), ("3", 3, 2), ("-", 3, 3),
            ("/", 4, 0), ("0", 4, 1), ("*", 4, 2), ("+", 4, 3),
            ("√", 5, 0), ("^", 5, 1), (".", 5, 2), ("=", 5, 3)
        ]
        for (texto, linha, coluna) in botoes:
            btn = ctk.CTkButton(self, text=texto, command=lambda t=texto: self._on_click(t))
            btn.grid(row=linha, column=coluna, sticky="nsew", padx=5, pady=5)

    def _on_click(self, texto):
        if texto == "=":
            resultado = self.calcular_callback(self.display.get())
            self.display.delete(0, 'end')
            self.display.insert('end', resultado)
        elif texto == "C":
            self.display.delete(0, 'end')
        elif texto == "⌫":
            valor_atual = self.display.get()
            if valor_atual:
                self.display.delete(len(valor_atual)-1, 'end')
        elif texto == "√":
            valor = self.display.get()
            if valor:
                expressao = f"({valor})**0.5"
                resultado = self.calcular_callback(expressao)
                self.display.delete(0, 'end')
                self.display.insert('end', resultado)
        elif texto == "^":
            self.display.insert('end', '**')
        else:
            self.display.insert('end', texto)