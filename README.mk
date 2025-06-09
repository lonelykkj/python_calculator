# Python Graphic Interface Project

## Descrição
Aplicação de interface gráfica desenvolvida em Python usando CustomTkinter.

## Instalação

1. Clone o repositório
2. Crie um ambiente virtual:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Linux/Mac
   # ou
   venv\Scripts\activate  # Windows
   ```
3. Instale as dependências:
   ```bash
   pip install -r requirements.txt
   ```

## Uso

```bash
python main.py
```

## Estrutura do Projeto

```
python_graphic_interface/
├── main.py              # Ponto de entrada da aplicação
├── requirements.txt     # Dependências do projeto
├── README.md           # Documentação
├── .gitignore          # Arquivos ignorados pelo Git
├── config/             # Configurações
│   └── settings.py
├── src/                # Código fonte
│   ├── __init__.py
│   ├── app.py          # Classe principal da aplicação
│   ├── components/     # Componentes reutilizáveis
│   │   ├── __init__.py
│   │   ├── login_form.py
│   │   └── base_window.py
│   ├── utils/          # Utilitários
│   │   ├── __init__.py
│   │   ├── auth.py
│   │   └── validators.py
│   └── styles/         # Estilos e temas
│       ├── __init__.py
│       └── themes.py
├── assets/             # Recursos (imagens, ícones)
│   ├── images/
│   └── icons/
├── tests/              # Testes
│   ├── __init__.py
│   └── test_auth.py
└── venv/               # Ambiente virtual
```