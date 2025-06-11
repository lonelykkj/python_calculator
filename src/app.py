import customtkinter as ctk
from ui.calculator_ui import CalculatorUI
from utils.calculator import calcular

ctk.set_appearance_mode("white")

app = ctk.CTk()
app.title("Calculadora")
app.geometry("300x400")

CalculatorUI(app, calcular_callback=calcular).pack(expand=True)

app.mainloop()
