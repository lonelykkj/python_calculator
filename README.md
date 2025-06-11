# Calculadora CustomTkinter

## 📝 Descrição
Calculadora simples feita em Python usando [CustomTkinter](https://github.com/TomSchimansky/CustomTkinter).

## 🚀 Características
- ✅ Interface moderna com CustomTkinter
- ✅ Operações básicas: +, -, *, /
- ✅ Botão "C" para limpar o display
- ✅ Interface centralizada e responsiva

## 🛠️ Instalação

### Ambiente Local

1. **Clone o repositório**
   ```bash
   git clone <repository-url>
   cd pyhton_calculator
   ```

2. **Crie o ambiente virtual e instale as dependências**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Linux/Mac
   # ou
   venv\Scripts\activate  # Windows
   pip install -r requirements.txt
   ```

3. **Execute a aplicação**
   ```bash
   python src/app.py
   ```

## 📁 Estrutura do Projeto

```
pyhton_calculator/
├── src/
│   ├── app.py                # Inicialização da aplicação
│   ├── ui/
│   │   └── calculator_ui.py  # Interface gráfica da calculadora
│   └── utils/
│       └── calculator.py     # Lógica de cálculo
├── requirements.txt          # Dependências
├── README.md                 # Documentação
└── ...
```

## 🎮 Uso

- Digite a expressão usando os botões.
- Clique em "=" para calcular.
- Clique em "C" para limpar o display.

## 📦 Build e Deploy

Para atualizar as dependências:
```bash
pip freeze > requirements.txt
```

## 🔧 Troubleshooting

1. **Erro de tkinter no Ubuntu/Debian**
   ```bash
   sudo apt install python3-tk
   ```

## 📄 Licença

Este projeto está sob a licença MIT.

## 🔗 Links Úteis

- [CustomTkinter Documentation](https://customtkinter.tomschimansky.com/)
- [Python Virtual Environments](https://docs.python.org/3/tutorial/venv.html)