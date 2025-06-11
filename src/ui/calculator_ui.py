import customtkinter as ctk

class CalculatorUI(ctk.CTkFrame):
    def __init__(self, master, calcular_callback):
        super().__init__(master)
        # self.grid(padx=20, pady=20)
        self.display = ctk.CTkEntry(self, width=240, font=("Arial", 24))
        self.display.grid(row=0, column=0, columnspan=4, pady=10)
        self.calcular_callback = calcular_callback
        self._criar_botoes()

    def _criar_botoes(self):
        botoes = [
            ("7", 1, 0), ("8", 1, 1), ("9", 1, 2), ("/", 1, 3),
            ("4", 2, 0), ("5", 2, 1), ("6", 2, 2), ("*", 2, 3),
            ("1", 3, 0), ("2", 3, 1), ("3", 3, 2), ("-", 3, 3),
            ("0", 4, 0), (".", 4, 1), ("=", 4, 2), ("+", 4, 3),
            ("C", 5, 0)
        ]
        for (texto, linha, coluna) in botoes:
            btn = ctk.CTkButton(self, text=texto, width=50, height=45, command=lambda t=texto: self._on_click(t))
            btn.grid(row=linha, column=coluna, padx=5, pady=5)
    def _on_click(self, texto):
        if texto == "=":
            resultado = self.calcular_callback(self.display.get())
            self.display.delete(0, 'end')
            self.display.insert('end', resultado)
        elif texto == "C":
            self.display.delete(0, 'end')
        else:
            self.display.insert('end', texto)