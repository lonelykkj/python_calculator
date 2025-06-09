#!/usr/bin/env python3
"""
Ponto de entrada principal da aplicação.
"""

import sys
import os

# Adiciona o diretório src ao path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

from app import create_app


def main():
    """Função principal da aplicação."""
    try:
        app = create_app()
        print("🚀 Iniciando aplicação GUI...")
        app.mainloop()
    except KeyboardInterrupt:
        print("\n👋 Aplicação encerrada pelo usuário")
    except Exception as e:
        print(f"❌ Erro ao executar aplicação: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
Ponto de entrada principal da aplicação.
"""

from src.app import App


def main():
    """Função principal da aplicação."""
    app = App()
    app.run()


if __name__ == "__main__":
    main()

