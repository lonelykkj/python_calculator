.PHONY: help setup install run test lint format freeze clean info

# Variáveis
PYTHON = python3
VENV = venv
VENV_BIN = $(VENV)/bin
PIP = $(VENV_BIN)/pip
PYTHON_VENV = $(VENV_BIN)/python

# Cores para output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

help:  ## Mostra esta ajuda
	@echo "Comandos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

setup: clean install  ## Configura o ambiente de desenvolvimento completo

install: $(VENV)/bin/activate  ## Instala dependências
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

$(VENV)/bin/activate:  ## Cria ambiente virtual
	$(PYTHON) -m venv $(VENV)

run: $(VENV)/bin/activate  ## Executa a aplicação
	$(PYTHON_VENV) src/app.py

test: $(VENV)/bin/activate  ## Executa os testes
	$(PYTHON_VENV) -m pytest tests/ -v || echo "Pytest não encontrado. Instale com: pip install pytest"

lint: $(VENV)/bin/activate  ## Executa linting do código
	$(PYTHON_VENV) -m flake8 src/

format: $(VENV)/bin/activate  ## Formata o código
	$(PYTHON_VENV) -m black src/ tests/

freeze: $(VENV)/bin/activate  ## Gera requirements.txt atualizado
	$(PIP) freeze > requirements.txt

clean:  ## Remove arquivos temporários e cache
	rm -rf $(VENV) __pycache__ src/__pycache__ src/*/__pycache__ tests/__pycache__ .pytest_cache *.pyc
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type d -name "__pycache__" -delete 2>/dev/null || true

info:  ## Mostra informações do projeto
	@echo "Nome: Python Graphic Interface"
	@echo "Versão Python: $(shell $(PYTHON) --version 2>/dev/null || echo 'Não encontrado')"
	@echo "Diretório: $(shell pwd)"
	@echo "Ambiente Virtual: $(if $(wildcard $(VENV)), ✓ Ativo, ✗ Não encontrado)"
	@echo "Requirements: $(if $(wildcard requirements.txt), ✓ requirements.txt, ✗ requirements.txt não encontrado)"

